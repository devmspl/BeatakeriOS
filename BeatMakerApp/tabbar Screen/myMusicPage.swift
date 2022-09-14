//
//  myMusicPage.swift
//  BeatMakerApp
//
//  Created by Macbook Air (ios) on 30/08/22.
//

import UIKit

class myMusicPage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
  
    
    @IBOutlet weak var myRecordingTable: UITableView!
    @IBOutlet weak var recentlyCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myRecordingTable.delegate = self
        myRecordingTable.dataSource = self
 
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = recentlyCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!  recentlyClass
        return cell
     
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.alert(message: "Functionality not developed yet")
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: recentlyCollection.frame.width/2.1,height: recentlyCollection.frame.height)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myRecordingTable.dequeueReusableCell(withIdentifier: "cell") as!  MyRecordingOutlet
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let vc =  storyboard?.instantiateViewController(withIdentifier: "lesson1") as! lesson1
            self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
}
class recentlyClass: UICollectionViewCell{
    @IBOutlet weak var recentlycoll: UIView!
    
}
class MyRecordingOutlet: UITableViewCell{
    @IBOutlet weak var recordingName: UILabel!
    
    @IBOutlet weak var recordingImg: UIImageView!
}
