//
//  FeedManager.swift
//  JSONWebServiceDemo
//
//  Created by Donald Angelillo on 2/21/16.
//  Copyright © 2016 Donald Angelillo. All rights reserved.
//

import UIKit
import Alamofire

class FeedManager {

    func getTopSongsForGenre(url: String, completion: (results: [MediaEntryModel]) -> Void) {
        Alamofire.request(.GET, url).responseJSON { (response) -> Void in

            var mediaEntries: [MediaEntryModel] = Array()
            
            if let json = response.result.value, feed = json["feed"] as? [String: AnyObject], entries = feed["entry"] as? [[String: AnyObject]] {
                for entry in entries {
                    let mediaEntry = MediaEntryModel(json: entry)
                    mediaEntries.append(mediaEntry)
                }
            }
            
            completion(results: mediaEntries)
        }
    }
}
