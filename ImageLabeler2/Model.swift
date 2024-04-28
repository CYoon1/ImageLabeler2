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
//    var labels = [LabelData]()
    
    @Attribute(.externalStorage)
    var imageData : Data?
    
    init() {
        
    }
}
