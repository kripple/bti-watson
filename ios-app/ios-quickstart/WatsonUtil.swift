//
//  WatsonUtil.swift
//  ios-quickstart
//
//  Created by Kristi bader on 3/27/16.
//  Copyright © 2016 Andrew Wagner. All rights reserved.
//

import Foundation
import WatsonDeveloperCloud

class WatsonUtil {
    
    static var TTS_USERNAME = "5fd5ef73-28a2-4b85-a7bd-b6d1c51c3a39"
    static var TTS_PASSWORD = "sFYpVkqvTIc0"
    static var ALCHEMY_API_KEY = "91bde65af203849c82d0857bece3c05de88e56a0"
    
    static func getSentiment(inputText : String, completion: (result: String?) -> Void) -> Void {
        let instance = AlchemyLanguage(apiKey: ALCHEMY_API_KEY)
        
        instance.getSentiment(requestType: .Text, html: nil, url: nil, text: inputText) { (error, returnValue) -> Void in
            if let sentiment = returnValue.docSentiment {
                completion(result:sentiment.type)
            }
        }
    }
    
    static func textToSpeech(inputText: String, completion: (data: NSData?, error: NSError?) -> Void) -> Void {
        let tts = TextToSpeech(username: TTS_USERNAME, password: TTS_PASSWORD)
        
        tts.synthesize(inputText) {
            (data, error) -> Void in
                completion(data: data, error: error)
        }
    }
    
}