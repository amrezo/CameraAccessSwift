//
//  CameraViewController.swift
//  CameraAccess
//
//  Created by Amr Al-Refae on 3/11/18.
//  Copyright © 2018 Amr Al-Refae. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButtonHideOrNot()
    }
    
    @IBAction func openCamera(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func openPhotos(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }

    }
    
    @IBAction func saveImage(_ sender: UIButton) {
        
        guard let imagePicked = imageView.image else { return }
        let imageData = UIImageJPEGRepresentation(imagePicked, 0.6)
        
        guard let unwrappedImageData = imageData else { return }
        let compressedJPGImage = UIImage(data: unwrappedImageData)
        
        guard let unwrappedCompressedJPGImage = compressedJPGImage else { return }
        UIImageWriteToSavedPhotosAlbum(unwrappedCompressedJPGImage, nil, nil, nil)
        
        
        let alert = UIAlertController(title: "Saved!", message: "Your image has been saved to your photos.", preferredStyle: .alert)
        let greatAction = UIAlertAction(title: "Great!", style: .cancel, handler: nil)
        alert.addAction(greatAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        dismiss(animated: true, completion: nil)
        
        saveButtonHideOrNot()
    }
    
    func saveButtonHideOrNot() {
        if imageView.image == nil {
            saveButton.isHidden = true
        } else {
            saveButton.isHidden = false
        }
    }
    


}

