//
//  MediaEntryModel.swift
//  JSONWebServiceDemo
//
//  Created by Donald Angelillo on 2/21/16.
//  Copyright © 2016 Donald Angelillo. All rights reserved.
//

import UIKit

class MediaEntryModel: CustomStringConvertible, NSCoding {
    var name:String? = nil
    var summary: String? = nil
    var artistName: String? = nil
    var previewURL: String? = nil
    
    init(json: [String: AnyObject]) {
        if let entryName = json["im:name"] as? [String: AnyObject], name = entryName["label"] as? String {
            self.name = name
        }
        
        if let entrySummary = json["summary"] as? [String: AnyObject], summary = entrySummary["label"] as? String {
            self.summary = summary
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
    }
    
    @objc required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as? String
        self.summary = aDecoder.decodeObjectForKey("summary") as? String
        self.previewURL = aDecoder.decodeObjectForKey("previewURL") as? String
    }
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.summary, forKey: "summary")
        aCoder.encodeObject(self.previewURL, forKey: "previewURL")
    }
    
    var description: String {
        return "name: \(self.name)\nsummary: \(self.summary)\npreviewURL: \(self.previewURL)\n\n"
    }

}
