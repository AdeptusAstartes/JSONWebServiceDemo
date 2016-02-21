//
//  MediaEntryModel.swift
//  JSONWebServiceDemo
//
//  Created by Donald Angelillo on 2/21/16.
//  Copyright © 2016 Donald Angelillo. All rights reserved.
//

import UIKit

class MediaEntryModel: CustomStringConvertible {
    var name:String? = nil
    var summary: String? = nil
    var artistName: String? = nil
    var previewURL: String? = nil
    var imagePath: String? = nil
    
    init(json: [String: AnyObject]) {
        if let entryName = json["im:name"] as? [String: AnyObject], name = entryName["label"] as? String {
            self.name = name
        }
        
        if let entrySummary = json["summary"] as? [String: AnyObject], summary = entrySummary["label"] as? String {
            self.summary = summary
        }
        
        if let entryArtist = json["im:artist"] as? [String: AnyObject], artistName = entryArtist["label"] as? String {
            self.artistName = artistName
        }
        
        if let link = json["link"] as? [[String: AnyObject]] {
            for item in link {
                if let attributes = item["attributes"] as? [String: AnyObject], type = attributes["im:assetType"] as? String {
                    if (type == "preview") {
                        if let previewURL = attributes["href"] as? String {
                            self.previewURL = previewURL
                        }
                    }
                }
            }

        }
        
        if let imageArray = json["im:image"] as? [[String: AnyObject]], image = imageArray.last, imagePath = image["label"] as? String {
            self.imagePath = imagePath
        }
    }
    
    var description: String {
        return "name: \(self.name)\nsummary: \(self.summary)\npreviewURL: \(self.previewURL)\n\n"
    }

}
