//
//  SongTableViewCell.swift
//  JSONWebServiceDemo
//
//  Created by Donald Angelillo on 2/21/16.
//  Copyright © 2016 Donald Angelillo. All rights reserved.
//

import UIKit
import AlamofireImage
import Font_Awesome_Swift

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var albumArtworkImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!

    var mediaEntry: MediaEntryModel? = nil
    var playButton: UIButton? = nil;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.playButton = UIButton(type: UIButtonType.Custom)
        self.showPlay()
        
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsetsZero
        self.layoutMargins = UIEdgeInsetsZero
    }
    
    override func prepareForReuse() {
        self.albumArtworkImageView.af_cancelImageRequest()
        self.showPlay()
    }
    
    func setMediaEntry(mediaEntry: MediaEntryModel) {
        self.mediaEntry = mediaEntry
        
        if let name = self.mediaEntry?.name {
            self.nameLabel.text = name
        }
        
        if let artistName = self.mediaEntry?.artistName {
            self.artistNameLabel.text = "Artist: \(artistName)"
        }
        
        if let imagePath = self.mediaEntry?.imagePath, url = NSURL(string: imagePath) {
            self.albumArtworkImageView.af_setImageWithURL(url)
        }
    }
    
    func showPlay() {
        self.playButton?.setFAText(prefixText: "", icon: FAType.FAPlayCircle, postfixText: "", size: 25, forState: UIControlState.Normal)
        self.playButton?.sizeToFit()
        self.accessoryView = self.playButton
    }
    
    func showPause() {
        self.playButton?.setFAText(prefixText: "", icon: FAType.FAPause, postfixText: "", size: 25, forState: UIControlState.Normal)
        self.playButton?.sizeToFit()
        self.accessoryView = self.playButton
    }
    
}
