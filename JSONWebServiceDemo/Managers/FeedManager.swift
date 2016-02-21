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
    static let topMoviesURL: String = "https://itunes.apple.com/us/rss/topmovies/limit=100/json"
    static let topSongsURL: String = "https://itunes.apple.com/us/rss/topsongs/genre=21/limit=100/json"
    
    func getTopMovies(completion: (results: [MediaEntryModel]) -> Void) {
        Alamofire.request(.GET, FeedManager.topMoviesURL).responseJSON { (response) -> Void in

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
