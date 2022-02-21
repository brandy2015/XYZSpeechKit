//
//  ViewController.swift
//  XYZSpeechKit
//
//  Created by zhangzihao on 2022/2/21.
//

import UIKit
import Speech
 
 
class ViewController: UIViewController {

    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var SpeechBTN: UIButton!
    
    @IBAction func SpeechBTN(_ sender: Any) {
        var tests : [String?] = []
        if  !XYZSpeechManager.share.audioEngine.isRunning {
            SpeechBTN.setTitle("停止录音", for: .normal)
            XYZSpeechManager.share.XYZ_startSpeech(speechVc: self, langugeSimple: "zh-CN") { speechType, finalText in
                print(speechType,finalText as Any)
                tests.append(finalText)
                if let finalText = finalText{
                    self.testLabel.text = finalText
                    if speechType == .stop{
                        let x :String = tests.compactMap { s1 in
                            return s1
                        }.last ?? ""
                        self.testLabel.text = x
                    }
                }
            }
        }else{
            SpeechBTN.setTitle("开始录音", for: .normal)
            XYZSpeechManager.share.XYZ_stopDictating()
        }
        
        
    }
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        
    }
}
