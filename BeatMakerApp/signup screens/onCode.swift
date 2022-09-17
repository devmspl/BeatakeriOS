//
//  onCode.swift
//  BeatMakerApp
//
//  Created by Macbook Air (ios) on 23/08/22.
//

import UIKit

class onCode: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var namee: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func SignupButtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "starting4") as! starting4
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginButtn(_ sender: Any) {
        
        if namee.text == " " {
            let alert = UIAlertController.init(title: "Login", message: "Please enter Password", preferredStyle: .alert)
            let complete = UIAlertAction.init(title: "Finish", style: .default, handler: nil)
            alert.addAction(complete)
            self.present(alert, animated: true, completion: nil)
        }else if password.text == " " {
            let alert = UIAlertController.init(title: "Login", message: "Please enter Password", preferredStyle: .alert)
            let complete = UIAlertAction.init(title: "Finish", style: .default, handler: nil)
            alert.addAction(complete)
            self.present(alert, animated: true, completion: nil)
            
            
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "tabbvar") as! tabbvar
        self.navigationController?.pushViewController(vc, animated: true)
    }
    }
    @IBAction func googleButtn(_ sender: Any) {
        if let url = URL(string: "https://accounts.google.com/v3/signin/identifier?dsh=S-1995585663%3A1663159176224530&continue=https%3A%2F%2Faccounts.google.com%2F&followup=https%3A%2F%2Faccounts.google.com%2F&passive=1209600&flowName=GlifWebSignIn&flowEntry=ServiceLogin&ifkv=AQDHYWo2-hjNIjOl6qD0zmbyo3dDSSwAOhKqXhi-cyt0NW8dHgByL0pAqNJqTWyZqlsBpWW4q8UD") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func facebookButtn(_ sender: Any) {
        if let url = URL(string: "https://www.facebook.com") {
            UIApplication.shared.open(url)
        }
    }
    
    
    
    
    
}

