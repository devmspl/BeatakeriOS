//
//  levelOne.swift
//  BeatMakerApp
//
//  Created by Macbook Air (ios) on 19/09/22.
//

import UIKit
import AVFoundation
class levelOne: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AVAudioRecorderDelegate,AVAudioPlayerDelegate {
 

    var audioPlayer : AVAudioPlayer?
    @IBOutlet weak var beatCollection: UICollectionView!
    
    @IBOutlet weak var recordingTimeLabel: UILabel!
    

    

    let drumImageArray = [UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum2"),UIImage.init(named: "drum2"),UIImage.init(named: "drum1"),UIImage.init(named: "drum2"),UIImage.init(named: "drum2")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beatCollection.delegate = self
        beatCollection.dataSource = self
        
        
    
         
     }
   
    
  



    
   

  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drumImageArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = beatCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BeatClass
        cell.drumImg.image = drumImageArray[indexPath.item]
        cell.drumButtn.setImage(drumImageArray[indexPath.item], for: .normal)
        cell.drumImg.image = UIImage()
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: beatCollection.frame.width/3-1, height: beatCollection.frame.height/5-2)
        

}
    func beats(music: String){
        let Sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: music, ofType: "wav")!)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: Sound as URL)
                audioPlayer?.prepareToPlay()
            } catch {
                print("Problem in getting File")
            }
        audioPlayer?.play()
    }
   
    @IBAction func tapbuttn(_ sender: Any) {
    
    print("hello")
        switch (sender as AnyObject).tag{
            case 0 :
                self.beats(music: "drum1")
            case 1 :
                self.beats(music: "drum2")
            case 2:
                self.beats(music: "drum3")
            case 3 :
                self.beats(music: "drum4")
            case 4:
                self.beats(music: "drum5")
            case 5:
                self.beats(music: "drum6")
            case 6:
                self.beats(music: "drum7")
            case 7:
                self.beats(music: "drum8")
            case 8:
                self.beats(music: "drum9")
            case 9:
                self.beats(music: "drum10")
            case 10:
                self.beats(music: "drum11")
            case 11:
                self.beats(music: "drum12")
            default:
                self.beats(music: "drum13")
            }
            
    }

     
}

class BeatClass: UICollectionViewCell{
    
    @IBOutlet weak var drumImg: UIImageView!
    
    @IBOutlet weak var drumButtn: UIButton!
}
