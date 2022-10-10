//
//  starting4.swift
//  BeatMakerApp
//
//  Created by Macbook Air (ios) on 25/08/22.
//

import UIKit
import Alamofire

class starting4: UIViewController {

    @IBOutlet weak var emailAdress: UITextField!
     @IBOutlet weak var fullName: UITextField!
     @IBOutlet weak var password: UITextField!
    
     @IBOutlet weak var confirmpassword: UITextField!
    
  let url = "http://93.188.167.68:8070/api/users/create"
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func signupButtn(_ sender: Any) {
        if emailAdress.text == "" {
        let alert = UIAlertController.init(title: "Login", message: "Please enter name", preferredStyle: .alert)
        let complete = UIAlertAction.init(title: "finish", style: .default, handler: nil)
        alert.addAction(complete)
        self.present(alert, animated: true, completion: nil)
        }else if fullName.text == "" {
            let alert = UIAlertController.init(title: "Login", message: "Please enter username", preferredStyle: .alert)
            let complete = UIAlertAction.init(title: "finish", style: .default, handler: nil)
            alert.addAction(complete)
            self.present(alert, animated: true, completion: nil)
        } else if password.text == "" {
                let alert = UIAlertController.init(title: "Login", message: "Please enter username", preferredStyle: .alert)
                let complete = UIAlertAction.init(title: "finish", style: .default, handler: nil)
                alert.addAction(complete)
                self.present(alert, animated: true, completion: nil)
        } else if confirmpassword.text == "" {
            
                    let alert = UIAlertController.init(title: "Login", message: "Please enter username", preferredStyle: .alert)
                    let complete = UIAlertAction.init(title: "finish", style: .default, handler: nil)
                    alert.addAction(complete)
                    self.present(alert, animated: true, completion: nil)
        }else {
            createUser()
    }
    }
        
    @IBAction func loginButtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "onCode") as! onCode
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
    
  

extension starting4 {
    func createUser()
    {
        let param: [String:Any] = ["name": fullName.text!,"email":emailAdress.text!,
        "phoneNo": "Mender",
        "password": password.text!,
        "deviceToken": "employee"]
        
      
            
        
        print(param)
        
        AF.request(url,method: .post,parameters: param,encoding: JSONEncoding.default).responseJSON{
            response in
            switch(response.result){
            case .success(let json):
                do{
                let status = response.response?.statusCode
                let respond = json as! NSDictionary
                print(respond)
                if status == 200{
                    let alert = UIAlertController.init(title: "successfully Completed", message: "Signup is Completed", preferredStyle: .alert)
                    let complete = UIAlertAction.init(title: "finish", style: .default, handler: nil)
                    alert.addAction(complete)
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let message = respond.object(forKey: "Please try again") as! String
                    print(message)
                }
                }
            case .failure(let error):do{
                print(error)
            }
            }
            }
            }
            }
