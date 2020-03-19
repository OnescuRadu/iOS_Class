//
//  ViewController.swift
//  CustomCellDemo
//
//  Created by Radu Onescu on 13/03/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var stories = [Story]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        stories.append(Story(txt: "hi there", img: ""))
        stories.append(Story(txt: "how are you doing?", img: ""))
//        stories.append(Story(txt: "nice car there", img: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg"))
        stories.append(Story(txt: "nice car there", img: "car0"))
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if stories[indexPath.row].hasImage(){
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? TableViewCellWithImage{
                cell.myLabel.text = stories[indexPath.row].text
                
                let image = UIImage(named: stories[indexPath.row].image)
                cell.myImage.image = image
                
//                let imageURL:URL=URL(string: stories[indexPath.row].image)!
//                let data=NSData(contentsOf: imageURL)
//                cell.myImage.image=UIImage(data: data! as Data)
                
                
                return cell
            }
        }
        else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? TableViewCellTextOnly{
                cell.myLabel.text = stories[indexPath.row].text
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return stories[indexPath.row].hasImage() ? 250 : 80
    }


}

