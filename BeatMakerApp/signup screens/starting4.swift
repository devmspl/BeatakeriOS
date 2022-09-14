//
//  starting4.swift
//  BeatMakerApp
//
//  Created by Macbook Air (ios) on 25/08/22.
//

import UIKit

class starting4: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func signupButtn(_ sender: Any) {
        let vc =  storyboard?.instantiateViewController(withIdentifier: "onCode") as! onCode
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func loginButtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "onCode") as! onCode
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
