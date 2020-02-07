//
//  ViewController3.swift
//  BusinessCardApp
//
//  Created by Radu Onescu on 07/02/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {

    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var replyLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var messageField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendMsg(_ sender: Any) {
        if let name = nameField.text , let message = messageField.text{
            messageLabel.text = "You: \(message)"
            replyLabel.text = "Tim: Hello \(name). I am in a meeting right now. I will reply to your message soon."
        }
    }
    
}
