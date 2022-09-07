//
//  CareerScreen.swift
//  BeatMakerApp
//
//  Created by Macbook Air (ios) on 31/08/22.
//

import UIKit

class CareerScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func theBestpAge(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "BeatScreen") as! BeatScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

 

}
