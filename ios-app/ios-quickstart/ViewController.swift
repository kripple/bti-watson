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
        
        let ttsHandler:(NSData?, NSError?)->Void = {data,error in
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
        
        let r = Reddit()
        let _ = r.getPosts("cats", completion: {(posts) in
            
            //right now just gets the title of the first post and says positive or negative
            WatsonUtil.getRedditSentiment(posts!, completion: {(result) in
                print(result)
                WatsonUtil.textToSpeech(result!, completion: ttsHandler)
        
            })
        }) 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

