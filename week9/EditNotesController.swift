//
//  EditNotesController.swift
//  MyNotebook
//
//  Created by Radu Onescu on 05/03/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import UIKit

protocol EditNoteDelegate {
    func editNote(note: Note)
}

class EditNotesController: UIViewController {

    var delegate: EditNoteDelegate?
    
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var headTextView: UITextView!
    
    var note: Note!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headTextView.text = note.head
        bodyTextView.text = note.body
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated);
        if self.isMovingFromParent
        {
            note.head = headTextView.text!
            note.body = bodyTextView.text!
            delegate?.editNote(note: note)
        }
    }

}
