//
//  VerSnapViewController.swift
//  Snapchat
//
//  Created by mbtec22 on 6/10/21.
//  Copyright © 2021 Tecsup. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class VerSnapViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!

    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text? = snap.descrip
        imageView.sd_setImage(with: URL(string: snap.imagenURL))
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    
        Database.database().reference().child("usuarios").child(Auth.auth().currentUser!.uid)
        .child("snaps").child(snap.id).removeValue()
        
        Storage.storage().reference().child("imagenes").child("\(snap.imagenID).jpg")
            .delete(completion: {(error) in print("Se eliminó la imagen correctamente")})
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
