//
//  HistoryModel.swift
//  ShakeAndStir
//
//  Created by Minhyun Cho on 2023/03/17.
//

import Foundation

struct HistoryModel: Codable {
    let userName: String
    let cocktailName: String
    
    init() {
        self.userName = ""
        self.cocktailName = ""
    }
    
    init(userName: String, cocktailName: String) {
        self.userName = userName
        self.cocktailName = cocktailName
    }
    
    private enum CodingKeys: String, CodingKey {
        case userName
        case cocktailName
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userName = try values.decode(String.self, forKey: .userName)
        cocktailName = try values.decode(String.self, forKey: .cocktailName)
    }
}
