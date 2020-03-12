//
//  CloudStorage.swift
//  MyNotebook
//
//  Created by Radu Onescu on 28/02/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class CloudStorage{
    private static var notes = [Note]()
    private static let db = Firestore.firestore()
    private static let storage = Storage.storage()
    private static let NOTESDOC = "notes"
    
    
    
    static func downloadImage(name: String, completion: @escaping ((_ data: Data) -> Void)){
        let imgRef = storage.reference(withPath: name)
        imgRef.getData(maxSize: 100000000) { (data,error) in
            if(error == nil){
                completion(data!)
            }
            else {
                print(error!)
            }
        }
    }
    
    static func uploadImage(image: UIImage) -> String {
        var imgName = UUID().uuidString + ".jpg"
        let data = image.jpegData(compressionQuality: 0.75)
        let newMetadata = StorageMetadata()
        newMetadata.contentType = "image/jpeg";
        
        let imgRef = storage.reference(withPath: imgName)
        imgRef.putData(data!, metadata: newMetadata) { (metadata, error) in
            if(error != nil){
                imgName = ""
            }
        }
        return imgName
    }
    
    static func startListener(completion: @escaping ((_ data: [Note]) -> Void)){
        db.collection(NOTESDOC).addSnapshotListener {
            (snap,error) in
            if(error == nil){
                self.notes.removeAll()
                for note in snap!.documents{
                    let map = note.data()
                    let head = map["head"] as! String
                    let body = map["body"] as! String
                    let image = map["image"] as! String
                    let newNote = Note(id: note.documentID, head: head, body: body, image: image)
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
        map["image"] = note.image
        docRef.setData(map)
    }
    
    static func createNote(head: String, body: String, image: String){
        let newDoc = db.collection(NOTESDOC).document()
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
        map["image"] = image
        newDoc.setData(map)
    }
}
