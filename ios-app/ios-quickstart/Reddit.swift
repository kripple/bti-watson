//
//  Reddit.swift
//  ios-quickstart
//
//  Created by Andrew Wagner on 3/19/16.
//  Copyright © 2016 Andrew Wagner. All rights reserved.
//

import Foundation
import Alamofire

class Reddit {
    func getPosts(query: String, completion: (posts: NSArray?) -> Void) {
        
        Alamofire.request(.GET, "https://www.reddit.com/search/.json", parameters: ["q": query])
            .responseJSON { response in
                debugPrint(response)

                do {
                    let jsonResponse = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableDictionary
                    let posts : NSArray = jsonResponse["data"]!["children"] as! NSArray
                    completion(posts: posts)
                    
                } catch {
                    print(error)
                }
                
        }
    }
}