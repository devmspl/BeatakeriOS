//
//  BeatScreen.swift
//  BeatMakerApp
//
//  Created by Macbook Air (ios) on 31/08/22.
//

import UIKit
import AVFoundation
import CoreData

class BeatScreen: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AVAudioRecorderDelegate,AVAudioPlayerDelegate{
 
    @IBOutlet weak var collectionOutt: UICollectionView!
    @IBOutlet weak var recordingTimeLabel: UILabel!
    @IBOutlet weak var record_btn_ref: UIButton!
    @IBOutlet weak var play_btn_ref: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer : AVAudioPlayer?
    var meterTimer: Timer!
    var isAudioRecordingGranted: Bool!
    var soundURL = ""
    var soundsNoteID = ""
    var soundsNoteTitle = "" 
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
    
    // Helper function inserted by Swift migrator.
    fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
        return input.rawValue
    }

    // Helper function inserted by Swift migrator.
    fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
        return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
    }
    
//    func recordSuccess(){
//
//
//            let soundsContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//            let sound = NSEntityDescription.insertNewObject(forEntityName: "Sounds", into: soundsContext) as! Sounds
//
//            sound.noteID = soundsNoteID         // V2.0
//            sound.noteTitle = soundsNoteTitle
//            sound.noteSoundURL = soundURL
//
////            var noteSoundTitle:String = "Sound " + Common().stringCurrentDate()
//
////            if (soundTitleTextField.text?.isEmpty)! {
////                noteSoundTitle = "Sound " + Common().stringCurrentDate()
////                soundTitleTextField.text = noteSoundTitle
////            } else {
////                noteSoundTitle =  ""
////            }
//
////            sound.noteSoundTitle =  noteSoundTitle
//            do {
//                try soundsContext.save()
//            } catch _ {
//            }
////            soundSaveConfirmationLabel.alpha = 1
////            soundSaveConfirmationLabel.text = "Saved " + noteSoundTitle
////            soundSaveConfirmationLabel.adjustsFontSizeToFitWidth = true
////            soundTitleTextField.text = ""
//
//            // Set the audio recorder ready to record the next audio with a unique audioFileName
//            let directoryURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in:
//                FileManager.SearchPathDomainMask.userDomainMask).first // as! NSURL
//
//            let audioFileName = UUID().uuidString + ".m4a"
//            let audioFileURL = directoryURL!.appendingPathComponent(audioFileName)
//            soundURL = audioFileName       // Sound URL to be stored in CoreData
//
//            // Setup audio session
//            let audioSession = AVAudioSession.sharedInstance()
//            do {
//                try audioSession.setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playAndRecord)), mode: .default)
//            } catch _ {
//            }
//
////            // Define the recorder setting
//            let recorderSetting = [AVFormatIDKey: NSNumber(value: kAudioFormatMPEG4AAC as UInt32),
//                                   AVSampleRateKey: 44100.0,
//                                   AVNumberOfChannelsKey: 2 ]
//
//            audioRecorder = try? AVAudioRecorder(url: audioFileURL, settings: recorderSetting)
//            audioRecorder?.delegate = self
//            audioRecorder?.isMeteringEnabled = true
//            audioRecorder?.prepareToRecord()
//
//
//
//        }
    
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
    @IBAction func backTapped(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    @IBAction func start_recording(_ sender: Any) {
        
        
            if(isRecording)
            {
                finishAudioRecording(success: true)
                recordingTimeLabel.text = "Rec"
                play_btn_ref.isEnabled = true
                isRecording = false
            }
            else
            {
                            setup_recorder()

                            audioRecorder.record()
                            meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
                recordingTimeLabel.text = "Stop"
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
                recordingTimeLabel.text = "STOP " + totalTimeString
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
                play_btn_ref.setTitle("Play", for: .normal)
//                recordSuccess()
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
                audioPlayer!.delegate = self
                audioPlayer!.prepareToPlay()
            }
            catch{
                print("Error")
            }
        }

        @IBAction func play_recording(_ sender: Any)
        {
            if(isPlaying)
            {
                audioPlayer!.stop()
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
                    audioPlayer?.play()
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
       
    
    @IBAction func tapbuttn(_ sender: UIButton) {
        print("hello")
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
        case 9:
            self.beats(music: "drum10")
        case 10:
            self.beats(music: "drum11")
        case 11:
            self.beats(music: "drum12")
        default:
            self.beats(music: "drum13")
        }
        
//        let Sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!)
//            do {
//                audioPlayer = try AVAudioPlayer(contentsOf: Sound as URL)
//                audioPlayer.prepareToPlay()
//            } catch {
//                print("Problem in getting File")
//            }
//            audioPlayer.play()
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

class DrumClass: UICollectionViewCell{
    

    @IBOutlet weak var drumImage: UIImageView!
    @IBOutlet weak var beatBtn: UIButton!

}
