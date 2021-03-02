//
//  MusicPlayer.swift
//  place42
//
//  Created by 최강훈 on 2021/03/01.
//  Copyright © 2021 최강훈. All rights reserved.
//

import Foundation
import AVFoundation

// Singleton
class MusicPlayer {
    static let shared = MusicPlayer()
    // AVAudioPlayer는 어떤 파일이나 iOS 디바이스 내에 있는 audio Data를
    // 재생하는 기능을 제공한다.
    var audioPlayer: AVAudioPlayer?
    
    func startBackgroundMusic() {
        // musicFile을 NSURL로 넣어주자.
        if let bundle = Bundle.main.path(forResource: "all-night-long", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            
            // "backgroundMusic"을 "audioPlayer"에 로드한다.
            // numberOfLoops가 -1이 되면 무한반복재생된다.
            // prepareToPlay한 이후 play를 해준다.
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: backgroundMusic as  URL)
                guard let audioPlayer = audioPlayer else {return}
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                print("played")
            } catch {
                print (error)
            }
        }
    }
}
