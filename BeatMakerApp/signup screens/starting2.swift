//
//  starting2.swift
//  BeatMakerApp
//
//  Created by Macbook Air (ios) on 25/08/22.
//

import UIKit

class starting2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    @IBAction func continueButt(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "starting3") as! starting3
        self.navigationController?.pushViewController(vc, animated: true)
    }
    


}
