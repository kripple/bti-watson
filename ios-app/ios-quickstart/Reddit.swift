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
    func getPosts(query: String){
        Alamofire.request(.GET, "https://www.reddit.com/search/.json", parameters: ["q": "cats"])
            .responseJSON { response in
                debugPrint(response)
        }
    }
}