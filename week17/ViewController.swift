//
//  ViewController.swift
//  WebsiteShaker
//
//  Created by Radu Onescu on 29/04/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    let websiteArray = [
        "https://time.com/",
        "https://www.bbc.com/news/topics/c77jz3mdqv1t/denmark",
        "https://www.independent.co.uk/topic/Denmark"]
    
    var currentPageIndex = 0;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: URL(string: websiteArray[currentPageIndex])!))
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if currentPageIndex == websiteArray.count - 1
            {
                currentPageIndex = 0;
            }
            else {
                currentPageIndex += 1
            }
            webView.load(URLRequest(url: URL(string: websiteArray[currentPageIndex])!))
        }
    }
    
    
}

