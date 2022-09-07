//
//  recentlyPage.swift
//  BeatMakerApp
//
//  Created by Macbook Air (ios) on 30/08/22.
//

import UIKit

class recentlyPage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
 
    
    @IBOutlet weak var collOut: UICollectionView!
    
   override func viewDidLoad() {
        super.viewDidLoad()
       collOut.delegate = self
       collOut.dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collOut.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!  firstCLass
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: collOut.frame.width/2.2, height: collOut.frame.height)
    }
}
class firstCLass: UICollectionViewCell{
    
    @IBOutlet weak var recentlyOut: UIView!
}
