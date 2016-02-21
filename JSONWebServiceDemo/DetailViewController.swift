//
//  DetailViewController.swift
//  JSONWebServiceDemo
//
//  Created by Donald Angelillo on 2/21/16.
//  Copyright © 2016 Donald Angelillo. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class DetailViewController: UIViewController {
    var mediaEntry: MediaEntryModel;
    
    init(mediaEntry: MediaEntryModel) {
        self.mediaEntry = mediaEntry
        
        super.init(nibName: "DetailViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let previewURL = self.mediaEntry.previewURL, url = NSURL(string: previewURL) {
            let moviePlayer = AVPlayer(URL: url)
            let moviePlayerController = AVPlayerViewController()
            
            moviePlayerController.player = moviePlayer
            self.addChildViewController(moviePlayerController)
            self.view.addSubview(moviePlayerController.view)
            moviePlayerController.view.frame = self.view.frame
            //moviePlayer.play()
        }
    }

}
