//
//  CareerScreen.swift
//  BeatMakerApp
//
//  Created by Macbook Air (ios) on 31/08/22.
//

import UIKit

class CareerScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let labelImg = [ UIImage.init(named: "round3"),UIImage.init(named: "round3"),UIImage.init(named: "round3")]
    
    let CountArray = ["3","2","1"]
     
    @IBOutlet weak var tableViewMusic: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollToBottom()
        tableViewMusic.delegate = self
        tableViewMusic.dataSource = self
        
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelImg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewMusic.dequeueReusableCell(withIdentifier: "cell") as!  LevelCell
        cell.labelImage.image = labelImg[indexPath.row]
        cell.lebelCount.text = CountArray[indexPath.row]
         return  cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    func scrollToBottom(){
                if self.labelImg.count != 0 {
                let IndexPath = IndexPath(row: self.labelImg.count-1, section: 0)
                self.tableViewMusic.scrollToRow(at: IndexPath, at: .bottom, animated: true)
               //    if (self.arraymsg.count != -1){
                    print("indexPath.row==\(IndexPath.row)")
             //  }
           }
       }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.row) {
        case 0 :
            let vc = storyboard?.instantiateViewController(withIdentifier: "lesson3") as! lesson3
            self.navigationController?.pushViewController(vc, animated: true)
        case 1 :
            let vc = storyboard?.instantiateViewController(withIdentifier: "Lesson2") as! Lesson2
            self.navigationController?.pushViewController(vc, animated: true)
        default :
            let vc = storyboard?.instantiateViewController(withIdentifier: "lesson1") as! lesson1
            self.navigationController?.pushViewController(vc, animated: true)
    
        }

}
    
}
class LevelCell: UITableViewCell{
    @IBOutlet weak var labelImage: UIImageView!
    
    @IBOutlet weak var lebelCount: UILabel!
}
extension UIViewController {

  func scrollToTop(animated: Bool) {
    if let tv = self as? UITableViewController {
        tv.tableView.setContentOffset(CGPoint.zero, animated: animated)
    } else if let cv = self as? UICollectionViewController{
        cv.collectionView?.setContentOffset(CGPoint.zero, animated: animated)
    } else {
        for v in view.subviews {
            if let sv = v as? UIScrollView {
                sv.setContentOffset(CGPoint.zero, animated: animated)
            }
        }
    }
  }
}
