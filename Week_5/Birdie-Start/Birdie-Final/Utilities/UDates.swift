//
//  UDates.swift
//  Birdie-Final
//
//  Created by Andrés Carrillo on 29/06/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation


///Utility to format a Date object to String
struct UDates {
    
    /**
     Takes a Date object as a Parameter and return a String with the received date in this format "Sep 12, 2:11 PM" -
     MMM d, yyyy
     - Returns: A String with the specified date
     */
    static func formatDate (_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        return dateFormatter.string(from: date)
    }
    
}
