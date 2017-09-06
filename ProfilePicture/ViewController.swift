//
//  ViewController.swift
//  ProfilePicture
//
//  Created by Apogee on 9/6/17.
//  Copyright © 2017 Apogee. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var img: UIImageView!
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        img.layer.cornerRadius = img.frame.size.width/2
        img.clipsToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped(tapGestureRecognizer:)))
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(tapGestureRecognizer)
        img.layer.cornerRadius = img.frame.size.width/2
        img.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func profileImageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        
        print("kashee done it")
        let myActionSheet = UIAlertController(title:"Profile Picture", message: "Select", preferredStyle: UIAlertControllerStyle.actionSheet)
        let viewPicture = UIAlertAction(title:"View Picture", style: UIAlertActionStyle.default){ (action) in
            let imageiew = self.img as! UIImageView
            let newImageView = UIImageView(image: imageiew.image)
            newImageView.frame = self.view.frame
            newImageView.backgroundColor = UIColor.black
            newImageView.contentMode = .scaleAspectFit
            newImageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self,action: #selector(self.dismissFullScreenImage))
            newImageView.addGestureRecognizer(tap)
            self.view.addSubview(newImageView)
            
        }
        let photoGallery = UIAlertAction(title: "Photo",style: UIAlertActionStyle.default){ (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum){
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        let camera = UIAlertAction(title:"Camera",style: UIAlertActionStyle.default){ (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        myActionSheet.addAction(viewPicture)
        myActionSheet.addAction(photoGallery)
        myActionSheet.addAction(camera)
        myActionSheet.addAction(UIAlertAction(title: "Cancel",style: UIAlertActionStyle.cancel,handler: nil))
        self.present(myActionSheet, animated: true, completion: nil)
    }
    
    func dismissFullScreenImage(sender: UITapGestureRecognizer){
        sender.view?.removeFromSuperview()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //img.layer.masksToBounds = true
        
        img.contentMode = .scaleAspectFit
        img.image = chosenImage
        img.layer.cornerRadius = img.frame.size.width/2
        img.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }


}

