//
//  CocktailModel.swift
//  ShakeAndStir
//
//  Created by Minhyun Cho on 2023/03/07.
//

import Foundation

struct CocktailModel: Codable {
    let name: String
    let base: [String]
    let taste: [String]
    let price: String
    
    init() {
        self.name = ""
        self.base = [""]
        self.taste = [""]
        self.price = ""
    }
    
    init(name: String, base: [String], taste: [String], price: String) {
        self.name = name
        self.base = base
        self.taste = taste
        self.price = price
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case base
        case taste
        case price
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        base = try values.decode([String].self, forKey: .base)
        taste = try values.decode([String].self, forKey: .taste)
        price = try values.decode(String.self, forKey: .price)
    }
}
