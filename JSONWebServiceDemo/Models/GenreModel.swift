//
//  GenreModel.swift
//  JSONWebServiceDemo
//
//  Created by Donald Angelillo on 2/21/16.
//  Copyright © 2016 Donald Angelillo. All rights reserved.
//

import UIKit


class GenreModel: CustomStringConvertible, NSCoding {
    var genreId: String? = nil
    var name:String? = nil
    var topSongsURL: String? = nil
    
    init(json: [String: AnyObject]) {
        
        if let genreId = json["id"] as? String {
            self.genreId = genreId
        }
        
        if let name = json["name"] as? String {
            self.name = name
        }
        
        if let rssUrls = json["rssUrls"] as? [String: AnyObject], topSongsURL = rssUrls["topSongs"] as? String {
            self.topSongsURL = topSongsURL
        }
    }
    
    @objc required init?(coder aDecoder: NSCoder) {
        self.genreId = aDecoder.decodeObjectForKey("genreId") as? String
        self.name = aDecoder.decodeObjectForKey("name") as? String
        self.topSongsURL = aDecoder.decodeObjectForKey("topSongsURL") as? String
    }
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.genreId, forKey: "genreId")
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.topSongsURL, forKey: "topSongsURL")
    }
    
    var description: String {
        return "genreId: \(self.genreId)\nname: \(self.name)\ntopSongsURL: \(self.topSongsURL)\n\n"
    }
    
}