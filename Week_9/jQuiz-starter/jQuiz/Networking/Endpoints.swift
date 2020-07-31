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
    case getHeaderImage = "https://cdn1.edgedatg.com/aws/v2/abc/ABCUpdates/blog/2900129/8484c3386d4378d7c826e3f3690b481b/1600x900-Q90_8484c3386d4378d7c826e3f3690b481b.jpg"
}
