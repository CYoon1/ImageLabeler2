//
//  Item.swift
//  ImageLabeler2
//
//  Created by Christopher Yoon on 4/28/24.
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
