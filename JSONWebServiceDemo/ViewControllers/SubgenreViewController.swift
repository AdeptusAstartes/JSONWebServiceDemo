//
//  SubgenreViewController.swift
//  JSONWebServiceDemo
//
//  Created by Donald Angelillo on 2/21/16.
//  Copyright © 2016 Donald Angelillo. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class SubgenreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var subgenre: GenreModel? = nil
    var mediaEntries: [MediaEntryModel] = Array()
    var feedManager: FeedManager
    let songTableViewCellReuseIdentifier: String = "songTableViewCellReuseIdentifier"
    let avPlayer: AVPlayer;
    var selectedIndexPath: NSIndexPath? = nil
    
    init(subgenre: GenreModel, mainGenreName: String) {
        self.subgenre = subgenre
        self.feedManager = FeedManager();
        
        self.avPlayer = AVPlayer()
        
        super.init(nibName: "SubgenreViewController", bundle: nil)
        
        if let name = self.subgenre?.genreName {
            self.title = "Top 10 \(mainGenreName): \(name) Songs"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 85.0
        self.tableView.rowHeight = UITableViewAutomaticDimension

        self.tableView.registerNib(UINib(nibName: "SongTableViewCell", bundle: nil), forCellReuseIdentifier: self.songTableViewCellReuseIdentifier)
        
        self.refreshFeed()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.stopPlayer()
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    
    //MARK: - UITableViewDataSource, UITableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mediaEntries.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCellWithIdentifier(self.songTableViewCellReuseIdentifier, forIndexPath: indexPath) as! SongTableViewCell
        
        let mediaEntry = self.mediaEntries[indexPath.row];
        tableViewCell.setMediaEntry(mediaEntry);
        return tableViewCell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath == self.selectedIndexPath) {
            if let tableViewCell = cell as? SongTableViewCell {
                tableViewCell.showPause()
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath == self.selectedIndexPath) {
            self.stopPlayer()
            self.selectedIndexPath = nil
            self.reloadTable()
            return;
        }
        
        self.selectedIndexPath = indexPath
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let mediaEntry = self.mediaEntries[indexPath.row]
        
        self.stopPlayer()
        
        if let previewURL = mediaEntry.previewURL, url = NSURL(string: previewURL) {
            let avPlayerItem: AVPlayerItem = AVPlayerItem(URL: url)
            self.avPlayer.replaceCurrentItemWithPlayerItem(avPlayerItem);
            self.avPlayer.play()
            
            self.reloadTable()
        }
    }
    
    
    
    func refreshFeed() {
        guard let topSongsURL = self.subgenre?.topSongsURL else {
            return
        }
        
        self.feedManager.getTopSongsForGenre(topSongsURL) { (results) -> Void in
            self.mediaEntries = results
            self.reloadTable()
        }
    }
    
    private func reloadTable() {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.tableView.reloadData()
        }
    }
    
    //MARK: - AVPlayer
    func stopPlayer() {
        if ((self.avPlayer.rate != 0) && (self.avPlayer.error == nil)) {
            self.avPlayer.pause();
        }
    }
}

