//
//  Note.swift
//  MyNotebook
//
//  Created by Radu Onescu on 28/02/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import Foundation
class Note {
    var id:String
    var head:String
    var body:String
    
    init(id: String, head: String, body: String){
        self.id = id
        self.head = head
        self.body = body
    }
}
