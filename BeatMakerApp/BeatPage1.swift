//
//  BeatPage1.swift
//  BeatMakerApp
//
//  Created by Macbook Air (ios) on 08/09/22.
//

import UIKit
import AVFoundation

class BeatPage1: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AVAssetResourceLoaderDelegate, URLSessionDelegate, URLSessionDataDelegate, URLSessionTaskDelegate  {
 

    @IBOutlet weak var beatCollection: UICollectionView!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    
    let drumImageArray = [UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum2"),UIImage.init(named: "drum2"),UIImage.init(named: "drum1"),UIImage.init(named: "drum2"),UIImage.init(named: "drum2")]
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        beatCollection.delegate = self
        beatCollection.dataSource = self
   
    }
 


    @IBAction func tapbuttn(_ sender: Any) {
        let Sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: Sound as URL)
                audioPlayer.prepareToPlay()
            } catch {
                print("Problem in getting File")
            }
            audioPlayer.play()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drumImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = beatCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DrumCell
        cell.beatBtn.tag = indexPath.item
        cell.beatBtn.setImage(drumImageArray[indexPath.item], for: .normal)
        cell.drumImage.image = UIImage()
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: beatCollection.frame.width/3-1, height: beatCollection.frame.height/5-2)
        
    }
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch (indexPath.row) {
        case 0 :
          
            let Sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: Sound as URL)
                    audioPlayer.prepareToPlay()
                } catch {
                    print("Problem in getting File")
                }
                audioPlayer.play()
        
        case 1 :
            let Sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: Sound as URL)
                    audioPlayer.prepareToPlay()
                } catch {
                    print("Problem in getting File")
                }
                audioPlayer.play()
        
            
        case 2:
            let Sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: Sound as URL)
                    audioPlayer.prepareToPlay()
                } catch {
                    print("Problem in getting File")
                }
                audioPlayer.play()
        
            
        case 3 :
            let Sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: Sound as URL)
                    audioPlayer.prepareToPlay()
                } catch {
                    print("Problem in getting File")
                }
                audioPlayer.play()
        
            
        case 4:
            let Sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: Sound as URL)
                    audioPlayer.prepareToPlay()
                } catch {
                    print("Problem in getting File")
                }
                audioPlayer.play()
        
            
        case 5:
            let Sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: Sound as URL)
                    audioPlayer.prepareToPlay()
                } catch {
                    print("Problem in getting File")
                }
                audioPlayer.play()
        
            
        case 6:
            let Sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: Sound as URL)
                    audioPlayer.prepareToPlay()
                } catch {
                    print("Problem in getting File")
                }
                audioPlayer.play()
        
            
        case 7:
            let Sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: Sound as URL)
                    audioPlayer.prepareToPlay()
                } catch {
                    print("Problem in getting File")
                }
                audioPlayer.play()
        
            
        case 8:
            let Sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: Sound as URL)
                    audioPlayer.prepareToPlay()
                } catch {
                    print("Problem in getting File")
                }
                audioPlayer.play()
        
        case 9:
            let Sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: Sound as URL)
                    audioPlayer.prepareToPlay()
                } catch {
                    print("Problem in getting File")
                }
                audioPlayer.play()
        
            
        case 10:
            let Sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: Sound as URL)
                    audioPlayer.prepareToPlay()
                } catch {
                    print("Problem in getting File")
                }
                audioPlayer.play()
        
            
        
        case 11:
            let Sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: Sound as URL)
                    audioPlayer.prepareToPlay()
                } catch {
                    print("Problem in getting File")
                }
                audioPlayer.play()
        
            
            
        default:
            let Sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: Sound as URL)
                    audioPlayer.prepareToPlay()
                } catch {
                    print("Problem in getting File")
                }
                audioPlayer.play()
        }
    }
    

    }

    

class DrumCell: UICollectionViewCell{
    @IBOutlet weak var beatBtn: UIButton!
    @IBOutlet weak var drumImage: UIImageView!
}


