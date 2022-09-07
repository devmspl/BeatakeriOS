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

    @IBAction func SignupButtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "starting4") as! starting4
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginButtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "tabbvar") as! tabbvar
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
