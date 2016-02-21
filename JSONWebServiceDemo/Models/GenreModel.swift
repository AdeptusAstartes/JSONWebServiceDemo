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
    var genreName:String? = nil
    var topSongsURL: String? = nil
    var isSubgenre: Bool = false
    var subgenres: [GenreModel] = Array();
    
    init(json: [String: AnyObject]) {
        if let genreId = json["id"] as? String {
            self.genreId = genreId
        }
        
        if let name = json["name"] as? String {
            self.genreName = name
        }
        
        if let rssUrls = json["rssUrls"] as? [String: AnyObject], topSongsURL = rssUrls["topSongs"] as? String {
            self.topSongsURL = topSongsURL
        }
        
        if let subgenresDict = json["subgenres"] as? [String: AnyObject] {
            for (_, value) in subgenresDict {
                if let genre = value as? [String: AnyObject] {
                    let genre = GenreModel(json: genre)
                    genre.isSubgenre = true
                    self.subgenres.append(genre)
                }
            }
        }
    }
    
    @objc required init?(coder aDecoder: NSCoder) {
        self.genreId = aDecoder.decodeObjectForKey("genreId") as? String
        self.genreName = aDecoder.decodeObjectForKey("name") as? String
        self.topSongsURL = aDecoder.decodeObjectForKey("topSongsURL") as? String
        self.isSubgenre = aDecoder.decodeBoolForKey("isSubgenre")
        self.subgenres = aDecoder.decodeObjectForKey("subgenres") as! [GenreModel]
    }
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.genreId, forKey: "genreId")
        aCoder.encodeObject(self.genreName, forKey: "name")
        aCoder.encodeObject(self.topSongsURL, forKey: "topSongsURL")
        aCoder.encodeBool(self.isSubgenre, forKey: "isSubgenre")
        aCoder.encodeObject(self.subgenres, forKey: "subgenres")
    }
    
    var description: String {
        return "genreId: \(self.genreId)\nname: \(self.genreName)\ntopSongsURL: \(self.topSongsURL)\nsubgenres: \(self.subgenres.count)\n\n"
    }
    
}