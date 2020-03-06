//
//  CloudStorage.swift
//  MyNotebook
//
//  Created by Radu Onescu on 28/02/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import Foundation
import FirebaseFirestore


class CloudStorage{
    private static var notes = [Note]()
    private static let db = Firestore.firestore()
    private static let NOTESDOC = "notes"
    
    static func startListener(completion: @escaping ((_ data: [Note]) -> Void)){
        db.collection(NOTESDOC).addSnapshotListener {
            (snap,error) in
            if(error == nil){
                self.notes.removeAll()
                for note in snap!.documents{
                    let map = note.data()
                    let head = map["head"] as! String
                    let body = map["body"] as! String
                    let newNote = Note(id: note.documentID, head: head, body: body)
                    self.notes.append(newNote)
                }
            }
            else {
                print(error!)
            }
            completion(notes)
        }
    }
    
    static func deleteNote(id:String){
        let docRef = db.collection(NOTESDOC).document(id)
        docRef.delete()
    }
    
    static func updateNote(note: Note){
        let docRef = db.collection(NOTESDOC).document(note.id)
        var map = [String:String]()
        map["head"] = note.head
        map["body"] = note.body
        docRef.setData(map)
    }
    
    static func createNote(head: String, body: String){
        let newDoc = db.collection(NOTESDOC).document()
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
        newDoc.setData(map)
    }
}
