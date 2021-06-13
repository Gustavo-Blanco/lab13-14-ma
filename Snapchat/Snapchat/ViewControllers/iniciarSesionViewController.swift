//
//  iniciarSesionViewController.swift
//  Snapchat
//
//  Created by mbtec22 on 5/20/21.
//  Copyright © 2021 Tecsup. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class iniciarSesionViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.text = "hola@gmail.com"
        passwordTextField.text = "tecsup"
        print(" ddffdffdfddffdfd")
        getUsers()
        // Do any additional setup after loading the view.
    }
    
    func getUsers() {
        Database.database().reference().child("usuarios").observeSingleEvent(of: .value, with: {(snapshot) in
            print(snapshot)
        })
    }
    
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        /*Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in print("Intentamos Iniciar Sesión")
         if error != nil {
         print("Tenemos el siguiente error:\(String(describing: error))")
         Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: {(user, error) in print("Intentamos crear un usuario")
         if error != nil {
         print("Tenemos el siguiente error:\(String(describing: error))")
         }
         else {
         print("El usuario fue creado exitosamente")
         Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
         self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
         }
         })
         } else {
         print("Inicio de Sesion exitoso")
         self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
         }
         
         })*/
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user,error) in
            print("Intentamos Iniciar Sesión")
            if error != nil {
                print("Tenemos el siguiente error - 1:\(error)")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user,error) in
                    print("Intentamos Crear un Usuario")
                    if error == nil {
                        print("El usuario fue creado existosamente")
                        self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                        let userData = [
                            "email":user!.user.email,
                            "uid": user!.user.uid
                        ]
                        let uid = user!.user.uid
                        Database.database().reference().child("usuarios").child(uid).setValue(userData)
                    } else {
                        print("Tenemos el siguiente error - 2:\(error?.localizedDescription)")
                    }
                })
            } else {
                print("Inicio de Sesion exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
            
        })
    }
    
}

