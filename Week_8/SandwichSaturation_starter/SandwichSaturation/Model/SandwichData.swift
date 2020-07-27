//
//  SandwichData.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import Foundation

enum SauceAmount: Decodable {
  case any
  case none
  case tooMuch
  
  var description: String {
    switch self {
    case .any:
      return "Any Amount"
    case .none:
      return "Too Dry"
    case .tooMuch:
      return "Drowning in Sauce"
    }
  }
}

struct SandwichData: Decodable {
  
  let name: String
  let sauceAmount: SauceAmount
  let imageName: String
    
  init(sandwichCoreData: Sandwich) {
    self.name = sandwichCoreData.name ?? ""
    self.sauceAmount = SauceAmount(rawValue: sandwichCoreData.sauceAmount ?? "Any Amount")!
    self.imageName = sandwichCoreData.imageName ?? "sandwich1"
  }
    
    init(name: String, sauceAmount: SauceAmount, imageName: String) {
    self.name = name
    self.sauceAmount = sauceAmount
    self.imageName = imageName
  }
}

extension SauceAmount: CaseIterable { }

extension SauceAmount: RawRepresentable {
  typealias RawValue = String
  
  init?(rawValue: RawValue) {
    switch rawValue {
    case "Either": self = .any
    case "None": self = .none
    case "Too Much": self = .tooMuch
    default: return nil
    }
  }
  
  var rawValue: String {
    switch self {
    case .any: return "Either"
    case .none: return "None"
    case .tooMuch: return "Too Much"
    }
  }
}
