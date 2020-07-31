//
//  NetworkingConstants.swift
//  jQuiz
//
//  Created by Andrés Carrillo on 30/07/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

enum Endpoints: String {
    case baseURL = "http://www.jservice.io/api"
    case getRandomClue = "/random"
    case getOptions = "/clues/?category="
    case getHeaderImage = "x"
}
