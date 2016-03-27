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
        
        let ttsHandler:(NSData?, NSError?)->Void = {
            (data:NSData?, error:NSError?) -> Void in
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
        
        let samplePositive = "I am super happy today, everything is perfect and amazing! " +
                             "The sun is shining and birds are chirping, I just want to skip " +
                             "down the street!"
        WatsonUtil.getSentiment(samplePositive, completion: {(result) in
            print(result)
            WatsonUtil.textToSpeech(result!, completion: ttsHandler)
        }) 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

