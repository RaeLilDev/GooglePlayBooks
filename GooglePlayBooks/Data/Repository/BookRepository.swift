//
//  BookRepository.swift
//  GooglePlayBooks
//
//  Created by Ye linn htet on 7/14/22.
//

import Foundation
import RealmSwift
import Combine

protocol BookRepository {
    
    func saveList(data: BookListResponse)
    
    func addBookToRecent(data: BookObject)
    
    func getLists() -> AnyPublisher<[ListObject], Never>
    
    func getRecentList() -> AnyPublisher<[BookObject], Never>
    
    func saveBooksInList(with listId: Int, data: MoreBookResponse)
    
    func getBooksByList(with listId: Int) ->AnyPublisher<[BookObject], Never>
    
    func addToWishList(data: BookObject) -> Bool
    
    func isBookInWishList(data: BookObject) -> Bool
    
    func deleteFromWishList(data: BookObject) -> Bool
    
    func getWishList(by attribute: String, order: Bool) -> AnyPublisher<[BookObject], Never>
}



class BookRepositoryImpl: BaseRepository, BookRepository {
   
    static let shared: BookRepository = BookRepositoryImpl()
    
    var bookListNotiToken: NotificationToken?
    
    var recentListNotiToken: NotificationToken?
    
    var bookListByIdNotiToken: NotificationToken?
    
    var wishListNotiToken: NotificationToken?
    
    private override init() { }
    
    
    func saveList(data: BookListResponse) {
        
        let listVOs = data.results?.lists?.map { $0.toListObject() } ?? [ListObject]()
        
        try! realmInstance.db.write {
            
            realmInstance.db.add(listVOs, update: .modified)
            
        }
        
    }
    
    func saveBooksInList(with listId: Int, data: MoreBookResponse) {
        
        let bookList = List<BookObject>()
        
        let bookVOs = data.results?.books?.map { $0.toBookObject() } ?? [BookObject]()
        
        bookVOs.forEach { bookList.append($0) }
        
        let listObject = realmInstance.db.object(ofType: ListObject.self, forPrimaryKey: listId)
        
        try! realmInstance.db.write {
            
            realmInstance.db.add(bookVOs, update: .modified)
            listObject?.books = bookList
        }
    }
    
    
    func addBookToRecent(data: BookObject) {
        
        try! realmInstance.db.write {
            
            realmInstance.db.add(data.toRecentViewObject(), update: .modified)
        }
        
    }
    
    
    func getLists() -> AnyPublisher<[ListObject], Never> {
        
        let results = realmInstance.db.objects(ListObject.self)
        
        let subject = CurrentValueSubject<[ListObject], Never>([])
        
        bookListNotiToken = results.observe{ changes in
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
    
    func getBooksByList(with listId: Int) ->AnyPublisher<[BookObject], Never> {
        
        let results = realmInstance.db.objects(ListObject.self).filter("listID=\(listId)")
        
        let subject = CurrentValueSubject<[BookObject], Never>([])
        
        bookListByIdNotiToken = results.observe({ changes in
            switch changes {
            case .update(let vo, _, _, _):
                subject.send(Array(vo.first!.books))
                
            case .initial(let vo):
                subject.send(Array(vo.first!.books))
                
            default:
                debugPrint("Default")
            }
        })
        
        return subject.eraseToAnyPublisher()
        
        
    }
    
    func getRecentList() -> AnyPublisher<[BookObject], Never> {
        
        let results = realmInstance.db.objects(RecentViewObject.self).sorted(byKeyPath: "date", ascending: false)
        
        let subject = CurrentValueSubject<[BookObject], Never>([])
        
        recentListNotiToken = results.observe{ changes in
            switch changes {
                
            case .initial(let vo):
                subject.send(Array(vo).map { $0.book ?? BookObject() })
                
            case .update(let vo, _, _, _):
                subject.send(Array(vo.map { $0.book ?? BookObject() }))
                
            case .error(_):
                debugPrint("Error Called")
            }
        }
        
        return subject.eraseToAnyPublisher()
        
    }
    
    
    func addToWishList(data: BookObject) -> Bool {
        do {
            try realmInstance.db.write {
                realmInstance.db.add(data.toWishListObject(), update: .modified)
            }
        } catch {
            return false
        }
        return true
        
    }
    
    
    func isBookInWishList(data: BookObject) -> Bool {
        guard let _ = realmInstance.db.object(ofType: WishListObject.self, forPrimaryKey: data.primaryIsbn13) else { return false }
        return true
    }
    
    
    
    func deleteFromWishList(data: BookObject) -> Bool {
        
        guard let object = realmInstance.db.object(ofType: WishListObject.self, forPrimaryKey: data.primaryIsbn13) else { return false }
        
        do {
            try realmInstance.db.write {
                realmInstance.db.delete(object)
            }
        } catch {
            return false
        }
        return true
        
    }
    
    
    func getWishList(by attribute: String, order: Bool) -> AnyPublisher<[BookObject], Never> {
        let results = realmInstance.db.objects(WishListObject.self).sorted(byKeyPath: attribute, ascending: order)
        
        let subject = CurrentValueSubject<[BookObject], Never>([])
        
        wishListNotiToken = results.observe{ changes in
            
            switch changes {
                
            case .initial(let vo):
                subject.send(Array(vo).map { $0.book ?? BookObject() })
                
            case .update(let vo, _, _, _):
                subject.send(Array(vo.map { $0.book ?? BookObject() }))
                
            case .error(_):
                debugPrint("Error Called")
            }
        }
        
        return subject.eraseToAnyPublisher()
        
    }
    
    
    
}
