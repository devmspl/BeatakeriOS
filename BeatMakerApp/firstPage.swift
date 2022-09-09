//
//  firstPage.swift
//  BeatMakerApp
//
//  Created by Macbook Air (ios) on 22/08/22.
//

import UIKit

class firstPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }


    
    @IBAction func continueButtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "starting2") as! starting2
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    


}
