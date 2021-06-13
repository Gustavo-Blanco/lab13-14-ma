//
//  ElegirUsuarioViewController.swift
//  Snapchat
//
//  Created by mbtec22 on 5/26/21.
//  Copyright © 2021 Tecsup. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ElegirUsuarioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    
    var usuarios : [Usuario] = []
    
    var imagenUrl = ""
    var descrip = ""
    var imagenID = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        print("entra...")
        
        Database.database().reference().child("usuarios").observe(DataEventType.childAdded, with: {(snapshot)
            in
            print("Aca?")
            print(snapshot)
            
            let usuario = Usuario()
            usuario.email = (snapshot.value as! NSDictionary)["email"] as! String
            usuario.uid = snapshot.key
            self.usuarios.append(usuario)
            self.tableView.reloadData()
            
        })
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let usuario = usuarios[indexPath.row]
        let snap = [
            //"from":usuario.email,
            "from":Auth.auth().currentUser!.email,
            "descripcion":descrip,"imagenURL":imagenUrl,
                    "imagenID":imagenID
        ]
        Database.database().reference().child("usuarios").child(usuario.uid).child("snaps")
            .childByAutoId().setValue(snap)
        
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let usuario = usuarios[indexPath.row]
        cell.textLabel?.text = usuario.email
        
        return cell//retornamos una celda cualquiera
    
    }
    
   

}
