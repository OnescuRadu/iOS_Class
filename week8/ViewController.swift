//
//  ViewController.swift
//  MyNotebook
//
//  Created by Radu Onescu on 14/02/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, EditNoteDelegate {

    var textArray = [String]() //initialize empty string array the will save all the texts
    var currentRowIndex : Int? = nil //the index of the current selected cell (if it is one)

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        tableView.dataSource = self //Setting the datasource of the table view
        tableView.delegate = self //Setting the delegate of the table view
        //tableView.setEditing(true, animated: true)
        
        // Get the saved array from the file if the file exists
        if let tempArray = self.getObject(fileName: "messages") as? [String] {
            textArray = tempArray
        }

    }
    
    //Add new row
    @IBAction func addNewNote(_ sender: Any) {
        textArray.append("New Note")
        tableView.reloadData()
        
        //If file was not saved print a message
        if saveObject(fileName: "messages", object: textArray) == false{
            print("File not saved")
        }
    }
    
    //Edit row
    func editNote(note: String){
        textArray[currentRowIndex!] = note
        tableView.reloadData()
        //If file was not saved print a message
        if saveObject(fileName: "messages", object: textArray) == false{
            print("File not saved")
        }
    }
    
    //Delete row
    func deleteRow(index: Int) {
        textArray.remove(at: index)
        tableView.reloadData()
        currentRowIndex = nil
        if saveObject(fileName: "messages", object: textArray) == false {
            print("File not saved")
        }
    }
    
    //Prepare for segue for ViewController2
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EditNoteController {
            destination.note = textArray[currentRowIndex!]
            destination.delegate = self
        }
     }
    
    //Set the number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    //Set the content of the cell
    //Each cell will have one element from the textArray
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
        cell?.textLabel?.text = textArray[indexPath.row]
        return cell!
    }
    
    //When row is pressed set the currentRowIndex
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRowIndex = indexPath.row
        performSegue(withIdentifier: "showNoteSegue", sender: nil)
    }
    
    
    //When button is pressed in editing mode call the deleteRow() func
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        deleteRow(index: indexPath.row)
    }
    
    //Toggle the table view editing mode using the Edit button
    @IBAction func toggleEdit(_ sender: Any) {
        if(tableView.isEditing == false)
        {
            tableView.setEditing(true, animated: true)
//            editButton.setTitle("Done", for: .normal)
        }
        else{
            tableView.setEditing(false, animated: true)
//            editButton.setTitle("Edit", for: .normal)
        }

    }
    
    
    //---Saving / Loading file from a directory
    // Save object in document directory
    func saveObject(fileName: String, object: Any) -> Bool {
        
        let filePath = getDirectoryPath().appendingPathComponent(fileName)
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
            try data.write(to: filePath)
            return true
        } catch {
            print("error is: \(error.localizedDescription)")
        }
        return false
    }
    
    // Get object from document directory
    func getObject(fileName: String) -> Any? {
        
        let filePath = self.getDirectoryPath().appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: filePath)
            let object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
            return object
        } catch {
            print("error is: \(error.localizedDescription)")
        }
        return nil
    }
    
    //Get the document directory path
    func getDirectoryPath() -> URL {
        let arrayPaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return arrayPaths[0]
    }
    

}
