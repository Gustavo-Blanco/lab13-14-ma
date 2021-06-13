//
//  ImagenViewController.swift
//  Snapchat
//
//  Created by mbtec22 on 5/23/21.
//  Copyright © 2021 Tecsup. All rights reserved.
//

import UIKit
import Firebase

class ImagenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descripcionTextField: UITextField!
    
    @IBOutlet weak var elegirContactoTapped: UIButton!
   
    var imagePicker = UIImagePickerController()
    var imagenID = NSUUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        
        elegirContactoTapped.isEnabled = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            //info[UIImagePickerControllerOriginalName] as! UIImage
        
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        elegirContactoTapped.isEnabled = true
        imagePicker.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func camaraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func elegirContactoTapped(_ sender: Any) {
        elegirContactoTapped.isEnabled = false
        
        let storageReference = Storage.storage()
        let imageFolder = storageReference.reference().child("images")
        
        
        //let imagenesFolder = Storage.storage().reference().child("imagenes")
        let imagenData = imageView.image!.pngData()!
        //let imagenData = UIImageJPEGRepresentation(imageView.image!, 0.1)!
        /*imageFolder.putData(imagenData, metadata: nil) { metadata, error in
            imageFolder.downloadURL { url, error in
                print("url")
                guard let url = url else {return}
                print(url.absoluteString)
                self.performSegue(withIdentifier: "seleccionarContactoSegue", sender: url.absoluteString)
            }
        }
        */
        
      
        
        imageFolder.child("\(imagenID).jpg").putData(imagenData, metadata: nil, completion: {(metadata,error)in print("Intentando subir la imagen")
            if error != nil {
                print("Ocurrio un error:\(error)")
            } else {
      
                self.performSegue(withIdentifier: "seleccionarContactoSegue", sender: metadata)
            }
            //
        })
    
        
        
        //performSegue(withIdentifier: "seleccionarContactoSegue",sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let siguienteVC = segue.destination as! ElegirUsuarioViewController
        siguienteVC.imagenUrl = sender as! String
        siguienteVC.descrip = descripcionTextField.text!
        
        siguienteVC.imagenID = imagenID
        
        
        
        
        /*let imagenesFolder = Storage.storage().reference().child("imagenes")
        let imagenData = imageView.image!.pngData()//UIImagePNGRepresentation(imageView.image!)!
        //putData(_:metadata:completion:)
        imagenesFolder.child("imagenes.png").putData(imagenData, metadata: nil, completion: {(metadata, error)in print("Intentando subir la imagen")
            if error != nil {
                print("Ocurrió un error:\(error)")
            }
            
        })*/
    }

}
