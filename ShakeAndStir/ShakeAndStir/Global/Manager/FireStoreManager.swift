//
//  FireStoreManager.swift
//  ShakeAndStir
//
//  Created by Minhyun Cho on 2023/03/07.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

final class FireStoreManager {
    private var documentListner: ListenerRegistration?
    static var shared = FireStoreManager()
    
    enum CollectionPaths: String {
        case Users, Cocktails, Histories
    }
    
    let document = Firestore.firestore()
    
    func setUserData(_ model: UserModel) throws {
        let userName: String = model.name
        let collectionPath = "\(CollectionPaths.Users)"
        
        try document.collection(collectionPath).document(userName).setData(from: model)
    }
    
    func setCocktailData(_ model: CocktailModel) throws {
        let cocktail: String = model.name
        let collectionPath = "\(CollectionPaths.Cocktails)"
        
        try document.collection(collectionPath).document(cocktail).setData(from: model)
    }
    
    func setHistory(time: String, model: HistoryModel) throws {
        let time: String = time
        let collectionPath = "\(CollectionPaths.Histories)"
        
        try document.collection(collectionPath).document(time).setData(from: model)
    }
    
    func getUserData() async throws -> [UserModel] {
        let collectionPath = "\(CollectionPaths.Users)"
        let result = try await document.collection(collectionPath).getDocuments()
        let data = try result.documents.map { snapshot in
            try snapshot.data(as: UserModel.self)
        }
        
        return data
    }
    
    func loadCockTailList() async throws -> [CocktailModel] {
        let collectionPath = "\(CollectionPaths.Cocktails)"
        let result = try await document.collection(collectionPath).getDocuments()
        let data = try result.documents.map { snapshot in
            try snapshot.data(as: CocktailModel.self)
        }
        
        return data
    }
}
