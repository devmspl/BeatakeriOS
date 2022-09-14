//
//  SettingScreen.swift
//  BeatMakerApp
//
//  Created by Macbook Air (ios) on 14/09/22.
//

import UIKit

class SettingScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
   
    @IBAction func faceboookButtnm(_ sender: Any) {
        if let url = URL(string: "https://www.facebook.com") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func instagram(_ sender: Any) {
        if let url = URL(string: "https://www.instagram.com") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func termMyData(_ sender: Any) {
        self.alert(message: "Functionality not developed yet")
    }
    
    @IBAction func manageMyData(_ sender: Any) {
        self.alert(message: "Functionality not developed yet")
    }
}
    
    
    

   
    
    


