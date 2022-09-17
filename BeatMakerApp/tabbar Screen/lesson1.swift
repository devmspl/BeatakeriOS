//
//  lesson1.swift
//  BeatMakerApp
//
//  Created by Macbook Air (ios) on 14/09/22.
//

import UIKit
import AVFoundation


class lesson1: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AVAudioPlayerDelegate {


    @IBOutlet weak var lessonOneTable: UICollectionView!
    
    var hideStart = false
    var audioPlayer : AVAudioPlayer?
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    fileprivate let seekDuration: Float64 = 10
    
    
 
 
    @IBOutlet weak var playBackSlider: UISlider!
    
   
    @IBOutlet weak var lblCurruntDuration: UILabel!
    
  
    @IBOutlet weak var playButn: UIButton!
    
    let drumImageArray = [UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum2"),UIImage.init(named: "drum2"),UIImage.init(named: "drum1"),UIImage.init(named: "drum2"),UIImage.init(named: "drum2")]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lessonOneTable.delegate = self
        lessonOneTable.dataSource = self
       
        
            let url = NSURL(fileURLWithPath: Bundle.main.path(forResource: "longDrum", ofType: "mp3")!)
        let playerItem:AVPlayerItem = AVPlayerItem(url: url as URL)
             player = AVPlayer(playerItem: playerItem)
          //add playbckslider
       
        playBackSlider.minimumValue = 0
              
        playBackSlider.addTarget(self, action: #selector(lesson1.playbackSliderValueChanged(_:)), for: .valueChanged)
              
              let duration : CMTime = playerItem.asset.duration
              let seconds : Float64 = CMTimeGetSeconds(duration)
        lblCurruntDuration.text = self.stringFromTimeInterval(interval: seconds)
              
              let duration1 : CMTime = playerItem.currentTime()
              let seconds1 : Float64 = CMTimeGetSeconds(duration1)
        lblCurruntDuration.text = self.stringFromTimeInterval(interval: seconds1)
              
        playBackSlider.maximumValue = Float(seconds)
        playBackSlider.isContinuous = true
        playBackSlider.tintColor = UIColor(red: 0.93, green: 0.74, blue: 0.00, alpha: 1.00)
              
               
               player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
                   if self.player!.currentItem?.status == .readyToPlay {
                       let time : Float64 = CMTimeGetSeconds(self.player!.currentTime());
                       self.playBackSlider.value = Float ( time );
                       
                       self.lblCurruntDuration.text = self.stringFromTimeInterval(interval: time)
                   }
                   
                   let playbackLikelyToKeepUp = self.player?.currentItem?.isPlaybackLikelyToKeepUp
                   if playbackLikelyToKeepUp == false{
                       print("IsBuffering")
                       self.playButn.isHidden = true
                     
                   } else {
                       //stop the activity indicator
                       print("Buffering completed")
                       self.playButn.isHidden = false
                     
                   }
                   
               }
               
               
           
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drumImageArray.count
        
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = lessonOneTable.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LessonOne
        if indexPath.item == 0{
            if self.hideStart == false{
                cell.startImage.isHidden = false

            }else{
                cell.startImage.isHidden = true
            }
           
        }else{
            cell.startImage.isHidden = true
        }
        if indexPath.item > 5{
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
        return CGSize(width: lessonOneTable.frame.width/3, height: lessonOneTable.frame.height/5)
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
        lessonOneTable.reloadData()
    switch sender.tag{
        case 0 :
        
            hideStart = true
        print("play Button")
         if player?.rate == 0
                
         {
             player!.play()
             self.playButn.isHidden = true
             self.playButn.isHidden = false
             playButn.setImage(UIImage(named: "ic_orchadio_pause"), for: UIControl.State.normal)
         } else {
             player!.pause()
             playButn.setImage(UIImage(named: "drum1"), for: UIControl.State.normal)
         }
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
//        case 6:
//            self.beats(music: "drum7")
//        case 7:
//            self.beats(music: "drum8")
//        case 8:
//            self.beats(music: "drum9")
//        case 9:
//            self.beats(music: "drum10")
//        case 10:
//            self.beats(music: "drum11")
//        case 11:
//            self.beats(music: "drum12")
        default:
            print("fail")
            
        }
    }
    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("hgkh")
    

    
    }

    @IBAction func backbuttn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func playbackSliderValueChanged(_ playBackSlider:UISlider)
      {
          let seconds : Int64 = Int64(playBackSlider.value)
          let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
          
          player!.seek(to: targetTime)
          
          if player!.rate == 0
          {
              player?.play()
          }
      }
      
      @objc func finishedPlaying( _ myNotification:NSNotification) {
          playButn.setImage(UIImage(named: "drum1"), for: UIControl.State.normal)
      }
      
      func stringFromTimeInterval(interval: TimeInterval) -> String {
          
          let interval = Int(interval)
          let seconds = interval % 60
          let minutes = (interval / 60) % 60
       
          return String(format: "%02d:%02d",  minutes, seconds)
      }
      

}
    
  


    

class LessonOne: UICollectionViewCell {
    @IBOutlet weak var drumImg: UIImageView!
    @IBOutlet weak var startImage: UIImageView!
    @IBOutlet weak var drumButtn: UIButton!
    
    
}
