//
//  QuestionCodable.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

struct Clue: Decodable {
    
    let id: Int
    let answer: String
    let question: String
//    let value: Int
    let airDate: String
    let createdAt: String
    let updatedAt: String
    let categoryId: Int
    let category: Category
    
    private enum CodingKeys: CodingKey {
        case id
        case answer
        case question
        case value
        case airdate
        case created_at
        case updated_at
        case category_id
        case game_id
        case invalid_count
        case category
    }
    
    init(from decoder: Decoder) throws {
        let container    = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id             = try container.decode(Int.self, forKey: .id)
        self.answer         = try container.decode(String.self, forKey: .answer)
        self.question       = try container.decode(String.self, forKey: .question)
//        self.value          = try container.decode(Int.self, forKey: .value)
        self.airDate        = try container.decode(String.self, forKey: .airdate)
        self.createdAt      = try container.decode(String.self, forKey: .created_at)
        self.updatedAt      = try container.decode(String.self, forKey: .updated_at)
        self.categoryId     = try container.decode(Int.self, forKey: .category_id)
        self.category       = try container.decode(Category.self, forKey: .category)
    }
}
