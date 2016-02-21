//
//  MediaEntryModel.swift
//  JSONWebServiceDemo
//
//  Created by Donald Angelillo on 2/21/16.
//  Copyright © 2016 Donald Angelillo. All rights reserved.
//

import UIKit

class MediaEntryModel {
    var name:String? = nil
    
    init(json: [String: AnyObject]) {
        if let entryName = json["im:name"] as? [String: AnyObject], name = entryName["label"] as? String {
            self.name = name
        }
    }

}
