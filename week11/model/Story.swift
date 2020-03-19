//
//  Story.swift
//  CustomCellDemo
//
//  Created by Radu Onescu on 13/03/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import Foundation
class Story {
    
    var text: String = ""
    var image: String = ""
    
    init(txt: String, img: String) {
        text = txt
        image = img
    }
    
    func hasImage() -> Bool {
        return image.count > 0
    }
}
