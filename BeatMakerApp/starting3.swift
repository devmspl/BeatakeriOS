//
//  starting3.swift
//  BeatMakerApp
//
//  Created by Macbook Air (ios) on 25/08/22.
//

import UIKit

class starting3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    @IBAction func contibuttn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "onCode") as! onCode
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
