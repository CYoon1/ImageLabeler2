//
//  Model.swift
//  ImageLabeler2
//
//  Created by Christopher Yoon on 4/28/24.
//

import Foundation
import SwiftData

@Model
class DataModel {
    var id = UUID()
    var dateCreated = Date()
    var name : String = "DataModel Name"
    
//    var lines = [LineData]()
    var labels = [LabelData]()
    
    @Attribute(.externalStorage)
    var imageData : Data?
    
    init() {
        
    }
}

struct LabelData: Codable, Identifiable {
    var id = UUID()
    var labelText : String
    var positionX : Double
    var positionY : Double
    
    init(labelText: String = "New Label", position: CGPoint = CGPoint(x: 50, y: 50)) {
        self.labelText = labelText
        self.positionX = Double(position.x)
        self.positionY = Double(position.y)
    }
}
