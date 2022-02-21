//
//  XYZSpeechManager.swift
//  XYZSpeechKit
//
//  Created by zhangzihao on 2022/2/21.
//
 
import UIKit
import Speech


public class XYZSpeechManager: NSObject {

    public enum XYZSpeechType: Int {
        case start
        case stop
        case finished
        case authDenied
    }

    public typealias XYZSpeechBlock = (_ speechType: XYZSpeechType, _ finalText: String?) -> Void
     
    
    public var parentVc: UIViewController!
    public var speechTask: SFSpeechRecognitionTask?
    // 声音处理器
    public var speechRecognizer: SFSpeechRecognizer?
    
    public static let share = XYZSpeechManager()
    
    public  var block: XYZSpeechBlock?
    
    // 语音识别器
    lazy var recognitionRequest: SFSpeechAudioBufferRecognitionRequest = {
        let recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        return recognitionRequest
    }()
    
 
    
    public lazy var audioEngine: AVAudioEngine = {
        let audioEngine = AVAudioEngine()
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: audioEngine.inputNode.outputFormat(forBus: 0)) { (buffer, audioTime) in
            // 为语音识别请求对象添加一个AudioPCMBuffer，来获取声音数据
            self.recognitionRequest.append(buffer)
        }
        return audioEngine
    }()
    
    
    public func XYZ_startSpeech(speechVc: UIViewController, langugeSimple: String, speechBlock: @escaping XYZSpeechBlock) {
        parentVc = speechVc
        block = speechBlock
        
        XYZ_checkmicroPhoneAuthorization { (microStatus) in
            
            
                if microStatus {
                    self.XYZ_checkRecognizerAuthorization(recongStatus: { (recStatus) in
                        if recStatus {
                            //  初始化语音处理器的输入模式 语音处理器准备就绪（会为一些audioEngine启动时所必须的资源开辟内存）
                            self.audioEngine.prepare()
                            if (self.speechTask?.state == .running) {   // 如果当前进程状态是进行中
                                // 停止语音识别
                               self.XYZ_stopDictating()
                            } else {   // 进程状态不在进行中
                                self.speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: langugeSimple))
                                guard (self.speechRecognizer != nil) else {
                                    self.showAlert("抱歉，暂不支持当前地区使用语音输入")
                                    return
                                }
                                self.XYZ_setCallBack(type: .start, text: nil)
                                // 开启语音识别
                                self.XYZ_startDictating()
                            }
                        } else {
                            self.showAlert("您已取消授权使用语音识别，如果需要使用语音识别功能，可以到设置中重新开启！")
                            self.XYZ_setCallBack(type: .authDenied, text: nil)
                        }
                    })
                } else {
                    //麦克风没有授权
                    self.showAlert("您已取消授权使用麦克风，如果需要使用语音识别功能，可以到设置中重新开启！")
                    self.XYZ_setCallBack(type: .authDenied, text: nil)
                }
           
            
            
        }
    }
}

 
extension XYZSpeechManager: SFSpeechRecognitionTaskDelegate {
    
    //判断语音识别权限
    public func XYZ_checkRecognizerAuthorization(recongStatus: @escaping (_ resType: Bool) -> Void) {
        let authorStatus = SFSpeechRecognizer.authorizationStatus()
        if authorStatus == .authorized {
            recongStatus(true)
        } else if authorStatus == .notDetermined {
            SFSpeechRecognizer.requestAuthorization { (status) in
                if status == .authorized {
                    recongStatus(true)
                } else {
                    recongStatus(false )
                }
            }
        } else {
            recongStatus(false)
        }
    }
    
    //检测麦克风
    public func XYZ_checkmicroPhoneAuthorization(authoStatus: @escaping (_ resultStatus: Bool) -> Void) {
        let microPhoneStatus = AVCaptureDevice.authorizationStatus(for: .audio)

        if microPhoneStatus == .authorized {
            authoStatus(true)
        } else if microPhoneStatus == .notDetermined {
            AVCaptureDevice.requestAccess(for: .audio, completionHandler: {(res) in
                if res {
                    authoStatus(true)
                } else {
                    authoStatus(false)
                }
            })
        } else {
            authoStatus(false)
        }
    }
    
    //开始进行
    public func XYZ_startDictating() {
        do {
            try audioEngine.start()
            speechTask = speechRecognizer!.recognitionTask(with: recognitionRequest) { (speechResult, error) in
                // 识别结果，识别后的操作
                if speechResult == nil {
                    return
                }
                self.XYZ_setCallBack(type: .finished, text: speechResult!.bestTranscription.formattedString)
            }
        } catch  {
            print(error)
            self.XYZ_setCallBack(type: .finished, text: nil)
        }
    }
    
    // 停止声音处理器，停止语音识别请求进程
    public func XYZ_stopDictating() {
        XYZ_setCallBack(type: .stop, text: nil)
        audioEngine.stop()
        recognitionRequest.endAudio()
        speechTask?.cancel()
    }
    
    public func XYZ_setCallBack(type: XYZSpeechType, text: String?) {
        if block != nil {
            block!(type, text)
        }
    }
    
    public func showAlert(_ message: String) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let firstAction = UIAlertAction(title: "知道了", style: .default, handler: {(action) in
            })
            let secondAction = UIAlertAction(title: "跳转设置", style: .default, handler: {(action) in
                self.Setting()
            })
            alertVC.addAction(secondAction)
            alertVC.addAction(firstAction)
            self.parentVc.present(alertVC, animated: true, completion: nil)
        }
    }
    
    
    public func Setting()  {
        guard let Setting = URL(string: UIApplication.openSettingsURLString) else{return}
        DispatchQueue.main.async {
            UIApplication.shared.open(Setting, options: Dictionary(), completionHandler: nil)
        }
        
    }
}
