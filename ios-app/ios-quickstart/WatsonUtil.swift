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
    static var CLASSIFIER_USERNAME = "c7a820d9-5dda-4aab-809b-6377aa5b780e"
    static var CLASSIFIER_PASSWORD = "M85qL8JciAW6"
    static var CLASSIFIER_ID = "cd6394x53-nlc-870"
    
    static func getSentiment(inputText : String, completion: (result: String?) -> Void) -> Void {
        let instance = AlchemyLanguage(apiKey: ALCHEMY_API_KEY)
        
        instance.getSentiment(requestType: .Text, html: nil, url: nil, text: inputText) { (error, returnValue) -> Void in
            if let sentiment = returnValue.docSentiment {
                completion(result:sentiment.type)
            }
        }
    }
    
    static func getRedditSentiment(posts : NSArray, completion: (result: String?) -> Void) -> Void {
        let instance = AlchemyLanguage(apiKey: ALCHEMY_API_KEY)
        let redditEntry : NSMutableDictionary = posts[0] as! NSMutableDictionary
        //TODO just getting the sentiment from the title of one of the posts to start for now...
        let title = redditEntry["data"]!["title"] as! String
        print("title: " + title)
        
        instance.getSentiment(requestType: .Text, html: nil, url: nil, text: title) { (error, returnValue) -> Void in
            if let sentiment = returnValue.docSentiment {
                completion(result:sentiment.type)
            }
        }
    }
    
    static func getSentimentFromUrl(url: String, completion: (result: String?) -> Void) ->
        Void {
            
        let instance = AlchemyLanguage(apiKey: ALCHEMY_API_KEY)
        instance.getSentiment(requestType: .URL, html: nil, url: url, text: nil) { (error,returnValue) -> Void in
            if let sentiment = returnValue.docSentiment {
                completion(result:sentiment.type)
            }
        }
    }
    
    static func createClassifier(completion: (result: String?) -> Void) -> Void {
        let classifierService =  NaturalLanguageClassifier(username: CLASSIFIER_USERNAME, password: CLASSIFIER_PASSWORD)
        
        let bundle = NSBundle.mainBundle()
        
        let trainerURL = bundle.URLForResource("weather_data_train", withExtension: "csv")
        let trainerMetaURL = bundle.URLForResource("training_meta", withExtension: "txt")
        
        classifierService.createClassifier(trainerMetaURL!, trainerURL: trainerURL!) {
            classifier, error in
            completion(result: classifier!.id!)
        }
        
    }
    
    static func getClassifier(completion: (result: NaturalLanguageClassifier.Classifier) -> Void) -> Void {
        let classifierService =  NaturalLanguageClassifier(username: CLASSIFIER_USERNAME, password: CLASSIFIER_PASSWORD)
        classifierService.getClassifier(CLASSIFIER_ID) { (classifier, error) -> Void in
            completion(result: classifier!)
        }
    }
    
    static func classify(text: String, completion: (result: String) -> Void) {
        let classifierService =  NaturalLanguageClassifier(username: CLASSIFIER_USERNAME, password: CLASSIFIER_PASSWORD)
        
        classifierService.classify(CLASSIFIER_ID, text: text) { (classification, error) -> Void in
            completion(result: (classification?.topClass)!)
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