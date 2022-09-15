//
//  Lesson2.swift
//  BeatMakerApp
//
//  Created by Macbook Air (ios) on 14/09/22.
//

import UIKit
import AVFoundation

class Lesson2: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {


    @IBOutlet weak var lessonTwoTable: UICollectionView!
    var audioPlayer : AVAudioPlayer?
   
   
    var hideStart = false
   
    
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    fileprivate let seekDuration: Float64 = 10
    let drumImageArray = [UIImage.init(named: "drum2"),UIImage.init(named: "drum2"),UIImage.init(named: "drum2"),UIImage.init(named: "drum2"),UIImage.init(named: "drum2"),UIImage.init(named: "drum2"),UIImage.init(named: "drum2"),UIImage.init(named: "drum2"),UIImage.init(named: "drum2"),UIImage.init(named: "drum2"),UIImage.init(named: "drum2"),UIImage.init(named: "drum2")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        lessonTwoTable.delegate = self
        lessonTwoTable.dataSource = self
        let url = URL(string: "AUDIO_URL_HERE")
        
        
        
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drumImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = lessonTwoTable.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LessonTwo
        if indexPath.item == 0{
            if self.hideStart == false{
                cell.startIMage.isHidden = false

            }else{
                cell.startIMage.isHidden = true
            }
           
        }else{
            cell.startIMage.isHidden = true
        }
        if indexPath.item > 8{
            cell.drumImg.isHidden = true
            cell.drumButtn.isHidden = true
        }else{
            cell.drumImg.isHidden = false
            cell.drumButtn.isHidden = false
        }
        
        cell.drumButtn.tag = indexPath.item
        cell.drumButtn.setImage(drumImageArray[indexPath.item], for: .normal)
        cell.drumImg.image = UIImage()
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: lessonTwoTable.frame.width/3, height: lessonTwoTable.frame.height/5)
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
    @IBAction func tapbuttn(_ sender: UIButton) {
        hideStart = true
        lessonTwoTable.reloadData()
     switch sender.tag{
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
       // case 9:
         //   self.beats(music: "drum10")
      //   case 10:
      //      self.beats(music: "drum11")
      //   case 11:
      //    self.beats(music: "drum12")
       default:
            print("fail")
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      

        print("fail")

}
    @IBAction func backbuttn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
class LessonTwo : UICollectionViewCell{
    
    @IBOutlet weak var startIMage: UIImageView!
    @IBOutlet weak var drumButtn: UIButton!
    @IBOutlet weak var drumImg: UIImageView!
}
