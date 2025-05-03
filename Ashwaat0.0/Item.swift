//
//  Item.swift
//  Ashwaat0.0
//
//  Created by Maryam Amer Bin Siddique on 01/11/1446 AH.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
