//
//  Category.swift
//  jQuiz
//
//  Created by Andrés Carrillo on 30/07/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

struct Category: Decodable {
    
    let id: Int
    let title: String
    let createdAt: String
    let updatedAt: String
    let cluesCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case created_at
        case updated_at
        case clues_count
    }
    
    init(from decoder: Decoder) throws {
        let container    = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id         = try container.decode(Int.self, forKey: .id)
        self.title      = try container.decode(String.self, forKey: .title)
        self.createdAt  = try container.decode(String.self, forKey: .created_at)
        self.updatedAt  = try container.decode(String.self, forKey: .updated_at)
        self.cluesCount = try container.decode(Int.self, forKey: .clues_count)
    }
}
