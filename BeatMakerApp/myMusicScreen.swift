//
//  myMusicScreen.swift
//  BeatMakerApp
//
//  Created by Macbook Air (ios) on 25/08/22.
//

import UIKit

class myMusicScreen: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  
   
    @IBOutlet weak var newOutlett: UICollectionView!
    
    
    @IBOutlet weak var populerOutlet: UICollectionView!
    @IBOutlet weak var collectionOutlet: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionOutlet.delegate = self
        collectionOutlet.dataSource = self
        newOutlett.delegate = self
        newOutlett.dataSource = self
        populerOutlet.dataSource = self
        populerOutlet.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionOutlet {
        return 10
        } else  if collectionView == newOutlett {
                    return 10
            }else{
         
                return 10
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionOutlet {
        let cell = collectionOutlet.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!  cellClass
            return cell
        }else if collectionView ==  newOutlett {
            let cell  = newOutlett.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! newOutlet
            return cell
        }else{
            let cell = populerOutlet.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!  populerClass
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionOutlet {
        return  CGSize(width: collectionOutlet.frame.width/3,height: collectionOutlet.frame.height/1)
        }else  if  collectionView == newOutlett {
            return  CGSize(width: populerOutlet.frame.width/2.5,height: populerOutlet.frame.height)
        }else{
            return  CGSize(width: populerOutlet.frame.width/2.5,height: populerOutlet.frame.height)
        }

}
}
class cellClass : UICollectionViewCell{
    @IBOutlet weak var resumeOutlet: UIView!
    
}

class newOutlet : UICollectionViewCell{
    
    @IBOutlet weak var newOutlet: UIView!
    
}
class populerClass: UICollectionViewCell{
    
    @IBOutlet weak var populerOutlet: UIView!
}
