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

class EditNotesController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var delegate: EditNoteDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var headTextView: UITextView!
    
    var note: Note!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headTextView.text = note.head
        bodyTextView.text = note.body
        CloudStorage.downloadImage(name: note.image) {
            data in self.showImage(data: data)
        }
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        bodyTextView.layer.borderWidth = 0.5
        bodyTextView.layer.borderColor = borderColor.cgColor
    }
    
    private func showImage(data: Data) {
        imageView.image = UIImage(data: data)
    }
    
    func showImagePickerController(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            editedImage.jpegData(compressionQuality: 0.75)
            let imageName = CloudStorage.uploadImage(image: editedImage) //uploadImage returns empty string if upload failed else returns the name of the image
            if(imageName != "") //check if upload was sucessfull
            {
                imageView.image = editedImage
                note.image = imageName
            }
           
        }
        else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            originalImage.jpegData(compressionQuality: 0.75)
            let imageName = CloudStorage.uploadImage(image: originalImage)
            imageView.image = originalImage
            note.image = imageName
            
        }
        dismiss(animated: true, completion: nil)
    }

    @IBAction func selectImage(_ sender: Any) {
        showImagePickerController()
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
