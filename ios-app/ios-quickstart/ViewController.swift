//
//  ViewController.swift
//  ios-quickstart
//
//  Created by Andrew Wagner on 3/14/16.
//  Copyright © 2016 Andrew Wagner. All rights reserved.
//

import UIKit
import WatsonDeveloperCloud

class ViewController: UIViewController {
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        let r = Reddit()
        let _ = r.getPosts("problems")
        
        let tts = TextToSpeech(username: "5fd5ef73-28a2-4b85-a7bd-b6d1c51c3a39", password: "sFYpVkqvTIc0")
        tts.synthesize("Text") {
            
            data, error in
            
            if let audio = data {
                
                do {
                    self.player = try AVAudioPlayer(data: audio)
                    self.player!.play()
                } catch {
                    print("Couldn't create player.")
                }
                
            } else {
                print(error)
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

