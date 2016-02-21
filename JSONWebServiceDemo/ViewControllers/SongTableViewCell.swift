//
//  SongTableViewCell.swift
//  JSONWebServiceDemo
//
//  Created by Donald Angelillo on 2/21/16.
//  Copyright © 2016 Donald Angelillo. All rights reserved.
//

import UIKit
import AlamofireImage

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var albumArtworkImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!

    var mediaEntry: MediaEntryModel? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsetsZero
        self.layoutMargins = UIEdgeInsetsZero
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
    
}
