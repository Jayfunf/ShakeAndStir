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
        case Users, Cocktails
    }
    
    let document = Firestore.firestore()
    
    func setUserData(_ model: UserModel) throws {
        let userName: String = model.name
        print(CollectionPaths.Users)
        let collectionPath = "\(CollectionPaths.Users)"
        
        try document.collection(collectionPath).document(userName).setData(from: model)
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
        let result = try await document.collection(collectionPath).order(by: "name", descending: true).getDocuments()
        let data = try result.documents.map { snapshot in
            try snapshot.data(as: CocktailModel.self)
        }
        
        return data
    }
}
