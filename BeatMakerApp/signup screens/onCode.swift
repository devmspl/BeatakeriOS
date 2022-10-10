//
//  onCode.swift
//  BeatMakerApp
//
//  Created by Macbook Air (ios) on 23/08/22.
//

import UIKit
import Alamofire

class onCode: UIViewController {

    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    let url = "http://93.188.167.68:8070/api/users/login"
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    
    @IBAction func SignupButtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "starting4") as! starting4
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginButtn(_ sender: Any) {
        
                   if Email.text == "" {
                   let alert = UIAlertController.init(title: "Login", message: "Please enter Email", preferredStyle: .alert)
                   let complete = UIAlertAction.init(title: "finish", style: .default, handler: nil)
                   alert.addAction(complete)
                   self.present(alert, animated: true, completion: nil)
                   }else if Password.text == "" {
                       let alert = UIAlertController.init(title: "Login", message: "Please enter Password", preferredStyle: .alert)
                       let complete = UIAlertAction.init(title: "finish", style: .default, handler: nil)
                       alert.addAction(complete)
                       self.present(alert, animated: true, completion: nil)
                   }else {
                       login()
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
extension onCode{
    func login(){
        let param: [String:Any] =
        [ "email": Email.text!,
          "password": Password.text!
        ]
             
        print(param)
        AF.request(url,method: .post,parameters: param,encoding: JSONEncoding.default).responseJSON {
            response in
            switch(response.result){
            case .success(let json) : do {
                let status = response.response?.statusCode
                let respond = json as! NSDictionary
                print(respond)
                if status == 200{
                    let data = respond.object(forKey: "data") as! NSDictionary
                    let id = data.object(forKey: "id") as! String
                    let token = response.response?.allHeaderFields["x-access-token"]
                    UserDefaults.standard.setValue(id, forKey: "id")
                    UserDefaults.standard.setValue(token, forKey: "token")
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbvar") as! tabbvar
                    self.navigationController?.pushViewController(vc, animated: true)
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
            }
            }
