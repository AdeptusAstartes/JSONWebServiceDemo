//
//  GenreManager.swift
//  JSONWebServiceDemo
//
//  Created by Donald Angelillo on 2/21/16.
//  Copyright © 2016 Donald Angelillo. All rights reserved.
//

import UIKit
import Alamofire

class GenreManager {
    static let sharedGenreManager: GenreManager = GenreManager()
    
    private let musicGenreId = "34"
    let musicGenreURL: String = "https://itunes.apple.com/WebObjects/MZStoreServices.woa/ws/genres?id=34"
    
    func getMusicGenres(completion: (results: [GenreModel]) -> Void) {
        Alamofire.request(.GET, self.musicGenreURL).responseJSON { (response) -> Void in
            
            var genres: [GenreModel] = Array()
            
            if let json = response.result.value, subgenresDict = json[self.musicGenreId] as? [String: AnyObject], subgenres = subgenresDict["subgenres"] as? [String: AnyObject] {
                for (_, value) in subgenres {
                    if let genre = value as? [String: AnyObject] {
                        let genre = GenreModel(json: genre)
                        genres.append(genre)
                    }
                }
                
            }
            
            print(genres)
            
            completion(results: genres)
        }
    }
}
