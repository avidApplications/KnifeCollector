//
//  KnifeViewController.swift
//  KnifeCollection
//
//  Created by Bradley Stovall on 3/17/17.
//  Copyright © 2017 Bradley Stovall. All rights reserved.
//

import UIKit

class KnifeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var knifeImageView: UIImageView!
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var imageChoice = UIImagePickerController()
    var knife : Knife? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageChoice.delegate = self
        
        if knife != nil {
           knifeImageView.image = UIImage(data: knife!.image as! Data)
            titleTextField.text = knife!.title
            
            addUpdateButton.setTitle("Update", for: .normal)
        } else{
            deleteButton.isHidden = true
        }

        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        imageChoice.sourceType = .photoLibrary
        
        present(imageChoice, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        knifeImageView.image = image
        
        imageChoice.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imageChoice.sourceType = .camera
        
        present(imageChoice, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        if knife != nil {
            knife!.title = titleTextField.text
            knife!.image = UIImagePNGRepresentation(knifeImageView.image!) as NSData?
        } else {
            let context = (UIApplication.shared.delegate as!
                AppDelegate).persistentContainer.viewContext
            let knife = Knife(context: context)
            knife.title = titleTextField.text
            knife.image = UIImagePNGRepresentation(knifeImageView.image!) as NSData?
            
        }
        
        
        
        (UIApplication.shared.delegate as!
            AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
        
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as!
            AppDelegate).persistentContainer.viewContext
        
        context.delete(knife!)
        
        (UIApplication.shared.delegate as!
            AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }


}
