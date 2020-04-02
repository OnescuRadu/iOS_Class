//
//  ViewController.swift
//  MediaCapture
//
//  Created by Radu Onescu on 27/03/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var textLabel: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self //assign the object from this class to handle image picking return
        // Do any additional setup after loading the view.
    }
    
    @IBAction func photosBtnPressed(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    fileprivate func launchCamera() {
        imagePicker.sourceType = .camera
        imagePicker.showsCameraControls = true
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraPhotoBtnPressed(_ sender: Any) {
        launchCamera()
    }
    
    
    @IBAction func addTextBtn(_ sender: Any) {
        //Provide a size
        //UIGraphicsBeginImageContext(<#T##size: CGSize##CGSize#>)
        //Create the text
        //NSAttributedString
        //Draw the image using draw()
        if let image = imageView.image
        {
            if let myText = textLabel.text{
                let createdText = NSAttributedString(string: myText, attributes:
                    [.font:UIFont(name: "Georgia", size: 50)!,
                     .strokeWidth: -3.0,
                     .strokeColor: UIColor.black,
                     .foregroundColor: UIColor.white])
               let size = CGSize(width: image.size.width/2, height: image.size.height/2)
                imageView.image = UIGraphicsImageRenderer(size:size).image {_ in
                    //Resize image
                    imageView.image!.draw(in: CGRect(origin: .zero, size: size))
                    //Draw the text
                    createdText.draw(at: CGPoint(x: 10, y:size.height/2))
                }
                infoLabel.text = "Text added and image resized to \(size.width)x\(size.height)"
            }
        }
        
    }
    
    @IBAction func cameraVideoBtnPressed(_ sender: Any) {
        imagePicker.mediaTypes = ["public.movie"]
        imagePicker.videoQuality = .typeMedium
        launchCamera()
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let url = info[.mediaURL] as? URL { //this will only bbe true if there is a video save it
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path){
                UISaveVideoAtPathToSavedPhotosAlbum(url.path, nil, nil, nil)
            }
        }
        else { //if we have an image
            let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            imageView.image = image
            infoLabel.text = ""
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    //Clear the info label when touches begin
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        infoLabel.text = ""
    }
    
    //Move the image on swipe
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchPoint = touches.first?.location(in: view){
            imageView.transform = CGAffineTransform(translationX: touchPoint.x - imageView.center.x, y: 0)
        }
    }
    
    //Check if image is on the left side or right side when touch ended
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchPoint = touches.first?.location(in: view){
            if(touchPoint.x < view.frame.minX + 15){
                //Clear the image, update the info label
                imageView.image = nil
                infoLabel.text = "Image Deleted."
            }
            else if(touchPoint.x > view.frame.maxX - 15){
                //SAVE the image, update the info label
                UIImageWriteToSavedPhotosAlbum(imageView.image!, nil, nil, nil)
                imageView.transform = CGAffineTransform(translationX: 0, y: 0)
                infoLabel.text = "Image Saved."
            }
            //set the imageView to initial position
            imageView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
}






