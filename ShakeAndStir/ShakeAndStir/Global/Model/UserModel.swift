//
//  UserModel.swift
//  ShakeAndStir
//
//  Created by Minhyun Cho on 2023/03/07.
//

import Foundation

struct UserModel: Codable {
    let name: String
    let preferFlavor: [String]
    
    init() {
        self.name = ""
        self.preferFlavor = [""]
    }
    
    init(name: String, preferFlavor: [String]) {
        self.name = name
        self.preferFlavor = preferFlavor
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case preferFlavor
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        preferFlavor = try values.decode([String].self, forKey: .preferFlavor)
    }
}
