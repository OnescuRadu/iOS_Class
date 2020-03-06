//
//  ViewNotesController.swift
//  MyNotebook
//
//  Created by Radu Onescu on 05/03/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import UIKit
import Firebase


class ViewNotesController: UITableViewController, EditNoteDelegate {
    var textArray = [Note]() //initialize empty string array the will save all the texts
    var currentRowIndex : Int? = nil //the index of the current selected cell (if it is one)
    @IBOutlet weak var addNoteButton: UIBarButtonItem!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        CloudStorage.startListener {
            (data: [Note]) in self.useData(data: data)
        }
    }
    
    private func useData(data: [Note]) {
        textArray.removeAll()
        textArray = data
        tableView.reloadData()
    }

    //Set the number of rows in the table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    //Set the content of the cell
    //Each cell will have one element from the textArray
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
        cell?.textLabel?.text = textArray[indexPath.row].head
        return cell!
    }
    
    @IBAction func addNewNote(_ sender: Any) {
        CloudStorage.createNote(head: "New Note", body: "")
        tableView.reloadData()
    }
    
    //Edit note
    func editNote(note: Note){
        CloudStorage.updateNote(note: note)
        tableView.reloadData()
    }
    
    //Delete note
    func deleteNote(index: Int) {
        CloudStorage.deleteNote(id: textArray[index].id)
        currentRowIndex = nil
    }
    
    //Prepare for segue for ViewController2
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EditNotesController {
            destination.note = textArray[currentRowIndex!]
            destination.delegate = self
        }
     }
    
    //When row is pressed set the currentRowIndex and perform segue
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRowIndex = indexPath.row
        performSegue(withIdentifier: "editNotesSegue", sender: nil)
    }
    
    //When button is pressed in editing mode call the deleteRow() func
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        deleteNote(index: indexPath.row)
    }
    
        //Toggle the table view editing mode using the Edit button
        @IBAction func toggleEdit(_ sender: Any) {
            if(tableView.isEditing == false)
            {
                tableView.setEditing(true, animated: true)
            }
            else{
                tableView.setEditing(false, animated: true)
            }

        }
}
