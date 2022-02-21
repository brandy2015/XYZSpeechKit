////
////  SpeechToTextObject.swift
////  SpeechToText
////
////  Created by 张子豪 on 2018/8/16.
////  Copyright © 2018年 zhangqian. All rights reserved.
////
//
//import UIKit
//import Speech
//import SoHow
//
//
//class XYZSpeech: NSObject {
//    
//    override init() {}
//    
// 
//    //调整语言
//    
//    static var SystemLanguage =  "zh-CN"
//    var speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: XYZSpeech.SystemLanguage))! ////"zh-Hans"/ //    语言识别变量
//    //!"ja-Kana"))!/))!//))! //"zh-TW" //""
//    
////    enum SystemLanguageX {
////        case Chinese = "zh-CN",case Eng = "en-US",case Fr = "fr_FR"
////    }
//    
//    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
//    var recognitionTask: SFSpeechRecognitionTask?
//    let audioEngine = AVAudioEngine()
//
//    
//    var EngineRunning:Bool?{
//        return audioEngine.isRunning
//    }
//    
//    static func 切换语言状态()  {
//        if XYZSpeech.SystemLanguage !=  "en-US"{
//            print("切换了英文")
//            XYZSpeech.SystemLanguage = "en-US"
//            //重新写入修改
////            XYZSpeech.currentSTT?.speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: XYZSpeech.SystemLanguage))!
//
//        }else{
//            print("切换了中文")
//            XYZSpeech.SystemLanguage = "zh-CN"
////            XYZSpeech.currentSTT?.speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: XYZSpeech.SystemLanguage))!
//        }
//    }
//    
//    func 配置初始状态()  {
//        SFSpeechRecognizer.requestAuthorization { (authStatus) in
//            
//            var isButtonEnabled = false
//            
//            switch authStatus {
//            case .authorized:
//                isButtonEnabled = true
//                
//            case .denied:
//                isButtonEnabled = false
//                print("User denied access to speech recognition")
//                
//            case .restricted:
//                isButtonEnabled = false
//                print("Speech recognition restricted on this device")
//                
//            case .notDetermined:
//                isButtonEnabled = false
//                print("Speech recognition not yet authorized")
//            @unknown default:
//                print()
//            }
//            
//            print(isButtonEnabled)
//        }
//    }
//    
//    
//    
//    
//    func startRecording(completion: @escaping ( SFSpeechRecognitionResult?,Error?) -> Void){//}(SpeechBTN:UIButton,commentTextField:UITextField,费用Field:UITextField)  {
//        self.配置初始状态()//检测权限使用情况
//        
//        
//        if recognitionTask != nil {  //1
//            recognitionTask?.cancel()
//            recognitionTask = nil
//        }
//        let audioSession = AVAudioSession.sharedInstance()  //2
//        do {
//            try audioSession.setCategory(.record, mode: .default, options: .allowAirPlay)
//            try audioSession.setMode(AVAudioSession.Mode.measurement)
//            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
//        } catch {
//            print("audioSession properties weren't set because of an error.")
//        }
//        
//        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()  //3
//        let inputNode = audioEngine.inputNode
//        //        guard let inputNode = audioEngine.inputNode else {
//        //            fatalError("Audio engine has no input node")
//        //        }  //4
//        
////        guard let recognitionRequest = recognitionRequest else {
////            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
////        } //5
//        
//        recognitionRequest?.shouldReportPartialResults = true  //6
//        
//        
//         print("运行到了这里2")
//        
//        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest!, resultHandler: { (result, error) in  //7
//            completion(result, error)
//            
//           
//        })
//        let recordingFormat = inputNode.outputFormat(forBus: 0)  //11
//        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
//            self.recognitionRequest?.append(buffer)
//        }
//        audioEngine.prepare()  //12
//        do {
//            try audioEngine.start()
//        } catch {
//            print("audioEngine couldn't start because of an error.")
//        }
//    }
//    
//    
//    deinit {
//        print("销毁了所有语音")
//        
//        
//        let inputNode = audioEngine.inputNode
//        inputNode.removeTap(onBus: 0)
//        inputNode.reset()
//        audioEngine.stop()
//        recognitionRequest?.endAudio()
//        recognitionTask?.cancel()
//        recognitionTask = nil
//        recognitionRequest = nil
//        
//        //记得移除通知监听
//        
//        print("销毁了")
//        NotificationCenter.default.removeObserver(self)
//    }
//}
