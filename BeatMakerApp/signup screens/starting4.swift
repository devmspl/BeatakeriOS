//
//  starting4.swift
//  BeatMakerApp
//
//  Created by Macbook Air (ios) on 25/08/22.
//

import UIKit
import Alamofire
import  IQKeyboardManagerSwift
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
        if password.text == "" || confirmpassword.text == "" || fullName.text == "" || emailAdress.text == ""  {
               let alertController = UIAlertController(title: "Error", message: "Please Enter All text Fields", preferredStyle: .alert)
               let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
               alertController.addAction(defaultAction)
               self.present(alertController, animated: true, completion: nil)
        } else if password.text != confirmpassword.text {
                  let alertController = UIAlertController(title: "Error", message: "Passwords don't Match", preferredStyle: .alert)
                  let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                  alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
              }
        else{
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
        if ReachabilityNetwork.isConnectedToNetwork(){
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
                        let message = respond.object(forKey: "error") as! String
                        print(message)
                        
                        
                    }
                    }
                case .failure(let error):do{
                    print(error)
                }
                }
                }
                }else{
                let alert = UIAlertController.init(title: "Login", message: "Please check internet connection", preferredStyle: .alert)
                let complete = UIAlertAction.init(title: "Finish", style: .default, handler: nil)
                alert.addAction(complete)
                self.present(alert, animated: true, completion: nil)
                }
                }
                }

