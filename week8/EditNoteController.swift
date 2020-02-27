//
//  EditNoteController.swift
//  MyNotebook
//
//  Created by Radu Onescu on 25/02/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import UIKit

protocol EditNoteDelegate {
    func editNote(note: String)
}

class EditNoteController: UIViewController {

    var delegate: EditNoteDelegate?
    
    @IBOutlet weak var textView: UITextView!
    
    var note: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = note
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated);
        if self.isMovingFromParent
        {
            delegate?.editNote(note: textView.text!)
        }
    }
    
}
