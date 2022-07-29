//
//  ShelfRepository.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/21/22.
//

import Foundation
import RealmSwift
import Combine

protocol ShelfRepository {
    
    
    func addShelf(data: ShelfObject) -> Bool
    
    func getShelfList() -> AnyPublisher<[ShelfObject], Never>
    
    func addBookToShelf(book: BookObject, shelf: ShelfObject) -> Bool
    
    func getShelfBooks(by attribute: String, order: Bool, shelfId: String) -> AnyPublisher<[BookObject], Never>
    
    func renameShelf(data: ShelfObject, shelfName: String) -> Bool
    
    func getShelf(shelf: ShelfObject) -> AnyPublisher<ShelfObject, Never>
    
    func deleteShelf(shelf: ShelfObject) -> Bool
}



class ShelfRepositoryImpl: BaseRepository, ShelfRepository {
   
    static let shared: ShelfRepository = ShelfRepositoryImpl()
    
    var shelfListNotiToken: NotificationToken?
    
    var shelfBookListNotiToken: NotificationToken?
    
    var shelfNotiToken: NotificationToken?
    
    private override init() { }
    
    
    
    func addShelf(data: ShelfObject) -> Bool {
        
        try! realmInstance.db.write {
            
            realmInstance.db.add(data, update: .modified)
        }
        
        return true
        
    }
    
    func renameShelf(data: ShelfObject, shelfName: String) -> Bool {
        
        try! realmInstance.db.write {
            data.shelfName = shelfName
        }
        
        return true
        
    }
    
    func getShelf(shelf: ShelfObject) -> AnyPublisher<ShelfObject, Never> {
        
        let results = realmInstance.db.objects(ShelfObject.self).filter("id = %@", shelf.id)
        
        let subject = CurrentValueSubject<ShelfObject, Never>(ShelfObject())
        
        if let shelf = results.first {
            subject.send(shelf)
        }
        
        shelfNotiToken = results.observe{ changes in
            
            switch changes {
            case .initial(let vo):
                if let shelf = vo.first {
                    subject.send(shelf)
                }
                
                
            case .update(let vo, _, _, _):
                if let shelf = vo.first {
                    subject.send(shelf)
                }
                
            case .error(_):
                debugPrint("Error Called")
            }
        }
        
        return subject.eraseToAnyPublisher()
        
    }
    
    func getShelfList() -> AnyPublisher<[ShelfObject], Never> {
        
        let results = realmInstance.db.objects(ShelfObject.self).sorted(byKeyPath: "shelfName", ascending: true)
        
        let subject = CurrentValueSubject<[ShelfObject], Never>([])
        
        if results.count > 0 {
            subject.send(Array(results))
        }
        
        shelfListNotiToken = results.observe{ changes in
            
            switch changes {
            case .initial(let vo):
                subject.send(Array(vo))
                
            case .update(let vo, _, _, _):
                subject.send(Array(vo))
                
            case .error(_):
                debugPrint("Error Called")
            }
        }
        return subject.eraseToAnyPublisher()
        
    }
    
    
    func addBookToShelf(book: BookObject, shelf: ShelfObject) -> Bool {
        
        let object = realmInstance.db.object(ofType: ShelfObject.self, forPrimaryKey: shelf.id) ?? ShelfObject()
        
        let shelfBookObject = getShelfBook(book: book, shelf: shelf)
        
        try! realmInstance.db.write {
            
            let shelfBooks: [ShelfBookObject] = Array(object.books)
            
            if !shelfBooks.contains(where: { $0.id == shelfBookObject.id }) {
                object.books.append(shelfBookObject)
                realmInstance.db.add(object, update: .modified)
                realmInstance.db.add(shelfBookObject, update: .modified)
            }
        }
        
        return true
    }
    
    
    func getShelfBooks(by attribute: String, order: Bool, shelfId: String) -> AnyPublisher<[BookObject], Never> {
        
        let results = realmInstance.db.objects(ShelfBookObject.self)
            .filter("shelfId == %@", shelfId)
            .sorted(byKeyPath: attribute, ascending: order)
        
        let subject = CurrentValueSubject<[BookObject], Never>([])
        
            shelfBookListNotiToken = results.observe{ changes in
                
                switch changes {
                    
                case .initial(let vo):
                    subject.send(Array(vo).map { $0.book ?? BookObject() })
                    
                case .update(let vo, _, _, _):
                    subject.send(Array(vo).map { $0.book ?? BookObject() })
                    
                case .error(_):
                    debugPrint("Error Called")
                }
            }
        
        
        
        return subject.eraseToAnyPublisher()
        
    }
    
    func deleteShelf(shelf: ShelfObject) -> Bool {
        
        let books = realmInstance.db.objects(ShelfBookObject.self).filter("shelfId == %@", shelf.id)
        
        do {
            try realmInstance.db.write {
                self.realmInstance.db.delete(books)
                self.realmInstance.db.delete(shelf)
                    
                }
            } catch let error as NSError {
                print("error - \(error.localizedDescription)")
                return false
                
            }
        
        return true
    }
    
    
    func getShelfBook(book: BookObject, shelf: ShelfObject) -> ShelfBookObject {
        let object = ShelfBookObject()
        object.id = "\(book.primaryIsbn13)\(shelf.id)"
        object.shelfId = shelf.id
        object.authorName = book.author
        object.date = Date()
        object.bookName = book.title
        object.book = book
        return object
    }
    
    
}
