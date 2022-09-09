//
//  BeatScreen.swift
//  BeatMakerApp
//
//  Created by Macbook Air (ios) on 31/08/22.
//

import UIKit
import AVFoundation


class BeatScreen: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AVAudioRecorderDelegate,AVAudioPlayerDelegate{
 
  
  
    @IBOutlet weak var collectionOutt: UICollectionView!
   
   
    @IBOutlet weak var recordingTimeLabel: UILabel!
    
    @IBOutlet weak var record_btn_ref: UIButton!
    
    @IBOutlet weak var play_btn_ref: UIButton!
  
   
 
  
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    var meterTimer: Timer!
    var isAudioRecordingGranted: Bool!
    var isRecording = false
    var isPlaying = false

    let drumImageArray = [UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum1"),UIImage.init(named: "drum2"),UIImage.init(named: "drum2"),UIImage.init(named: "drum1"),UIImage.init(named: "drum2"),UIImage.init(named: "drum2")]
   
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
   
        collectionOutt.delegate = self
        collectionOutt.dataSource = self
        check_record_permission()
       }

       func check_record_permission()
       {
           switch AVAudioSession.sharedInstance().recordPermission {
           case AVAudioSession.RecordPermission.granted:
               isAudioRecordingGranted = true
               break
           case AVAudioSession.RecordPermission.denied:
               isAudioRecordingGranted = false
               break
           case AVAudioSession.RecordPermission.undetermined:
               AVAudioSession.sharedInstance().requestRecordPermission({ (allowed) in
                       if allowed {
                           self.isAudioRecordingGranted = true
                       } else {
                           self.isAudioRecordingGranted = false
                       }
               })
               break
           default:
               break
           }
       }
    func getDocumentsDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    func getFileUrl() -> URL
    {
        let filename = "myRecording.m4a"
        let filePath = getDocumentsDirectory().appendingPathComponent(filename)
    return filePath
    }
    
    func setup_recorder()
    {
        if isAudioRecordingGranted
        {
            let session = AVAudioSession.sharedInstance()
            do
            {
                try session.setCategory(AVAudioSession.Category.playAndRecord, options: .defaultToSpeaker)
                try session.setActive(true)
                let settings = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 44100,
                    AVNumberOfChannelsKey: 2,
                    AVEncoderAudioQualityKey:AVAudioQuality.high.rawValue
                ]
                audioRecorder = try AVAudioRecorder(url: getFileUrl(), settings: settings)
                audioRecorder.delegate = self
                audioRecorder.isMeteringEnabled = true
                audioRecorder.prepareToRecord()
            }
            catch {
//                display_alert(msg_title: "Error", msg_desc: error.localizedDescription, action_title: "OK")
                let alert = UIAlertController(title: "Beat", message: "Error", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
            }
        }
        else
        {
            let alert = UIAlertController(title: "Beat", message: "Error", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        }
    }
    
    @IBAction func start_recording(_ sender: Any) {
        
        
            if(isRecording)
            {
                finishAudioRecording(success: true)
                record_btn_ref.setTitle("Record", for: .normal)
                play_btn_ref.isEnabled = true
                isRecording = false
            }
            else
            {
                            setup_recorder()

                            audioRecorder.record()
                            meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
                            record_btn_ref.setTitle("Stop", for: .normal)
                            play_btn_ref.isEnabled = false
                            isRecording = true
                        }
        }

    
    @objc func updateAudioMeter(timer: Timer)
        {
            if audioRecorder.isRecording
            {
               
                let min = Int(audioRecorder.currentTime / 60)
                let sec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 60))
                let totalTimeString = String(format: "%02d:%02d", min, sec)
                recordingTimeLabel.text = totalTimeString
                audioRecorder.updateMeters()
            }
        }

        func finishAudioRecording(success: Bool)
        {
            if success
            {
                audioRecorder.stop()
                audioRecorder = nil
                meterTimer.invalidate()
                print("recorded successfully.")
            }
            else
            {
                display_alert(msg_title: "Error", msg_desc: "Recording failed.", action_title: "OK")
            }
        }
        func prepare_play()
        {
            do
            {
                audioPlayer = try AVAudioPlayer(contentsOf: getFileUrl())
                audioPlayer.delegate = self
                audioPlayer.prepareToPlay()
            }
            catch{
                print("Error")
            }
        }

        @IBAction func play_recording(_ sender: Any)
        {
            if(isPlaying)
            {
                audioPlayer.stop()
                record_btn_ref.isEnabled = true
                play_btn_ref.setTitle("Play", for: .normal)
                isPlaying = false
            }
            else
            {
                if FileManager.default.fileExists(atPath: getFileUrl().path)
                {
                    record_btn_ref.isEnabled = false
                    play_btn_ref.setTitle("pause", for: .normal)
                    prepare_play()
                    audioPlayer.play()
                    isPlaying = true
                }
                else
                {
                    let alert = UIAlertController(title: "Beat", message: "Error", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                }
            }
        }
        func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool)
        {
            if !flag
            {
                finishAudioRecording(success: false)
            }
            play_btn_ref.isEnabled = true
        }

 
            func display_alert(msg_title : String , msg_desc : String ,action_title : String)
            {
                let ac = UIAlertController(title: msg_title, message: msg_desc, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: action_title, style: .default)
                {
                    (result : UIAlertAction) -> Void in
                _ = self.navigationController?.popViewController(animated: true)
                })
                present(ac, animated: true)
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
        let cell = collectionOutt.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DrumClass
        cell.beatBtn.tag = indexPath.item
        cell.beatBtn.setImage(drumImageArray[indexPath.item], for: .normal)
        cell.drumImage.image = UIImage()
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionOutt.frame.width/3-1, height: collectionOutt.frame.height/5-2)
        
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

class DrumClass: UICollectionViewCell{
    

    @IBOutlet weak var drumImage: UIImageView!
    @IBOutlet weak var beatBtn: UIButton!
}
