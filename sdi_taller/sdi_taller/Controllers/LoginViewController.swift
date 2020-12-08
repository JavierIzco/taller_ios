//
//  ViewController.swift
//  sdi_taller
//
//  Created by usuario on 24/11/2020.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var valorSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loginButton.layer.cornerRadius = 5
        
        self.valorSlider.value = 20
        self.valorSlider.maximumValue = 80
        self.valorSlider.isHidden = true
        
        
    }

    @IBAction func loginButton(_ sender: Any) {
        
        print("Email: \(self.emailTextField.text ?? "")")
        print("Password: \(self.passwordTextField.text ?? "")")
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let listadoController = storyBoard.instantiateViewController(withIdentifier: "listado") as! ListadoController
        listadoController.modalPresentationStyle = .fullScreen
        self.present(listadoController, animated:false, completion:nil)
        
        
    }
    
    @IBAction func cambiaSlider(_ sender: Any) {
        
        print("Slider: \(self.valorSlider.value)" )
    }
}

