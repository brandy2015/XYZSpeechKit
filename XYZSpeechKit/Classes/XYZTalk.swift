//
//  XYZTalk.swift
//  XYZSpeechKit
//
//  Created by zhangzihao on 2022/2/21.
//

import UIKit
import Speech

class XYZTalkKit {

}
////MARK: 开始/停止转换
//extension XYZTalkKit{
//    //开始转换
//    fileprivate func startTranslattion(){
//        //1. 创建需要合成的声音类型
//        let voice = AVSpeechSynthesisVoice(language: "zh-CN")
//        
//        //2. 创建合成的语音类
//        let utterance = AVSpeechUtterance(string: textView.text)
//        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
//        utterance.voice = voice
//        utterance.volume = 1
//        utterance.postUtteranceDelay = 0.1
//        utterance.pitchMultiplier = 1
//        //开始播放
//        avSpeech.speak(utterance)
//    }
//    
//    //暂停播放
//    fileprivate func pauseTranslation(){
//        avSpeech.pauseSpeaking(at: .immediate)
//    }
//    
//    //继续播放
//    fileprivate func continueSpeek(){
//        avSpeech.continueSpeaking()
//    }
//    
//    //取消播放
//    fileprivate func cancleSpeek(){
//        avSpeech.stopSpeaking(at: .immediate)
//    }
//}
