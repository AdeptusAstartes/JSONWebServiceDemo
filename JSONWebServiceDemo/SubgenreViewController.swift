//
//  SubgenreViewController.swift
//  JSONWebServiceDemo
//
//  Created by Donald Angelillo on 2/21/16.
//  Copyright © 2016 Donald Angelillo. All rights reserved.
//

import UIKit

class SubgenreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var subgenre: GenreModel? = nil
    var mediaEntries: [MediaEntryModel] = Array()
    var feedManager: FeedManager
    let subgenreReuseIdentifer: String = "subgenreReuseIdentifer"
    
    init(subgenre: GenreModel, mainGenreName: String) {
        self.subgenre = subgenre
        self.feedManager = FeedManager();
        
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
        
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: self.subgenreReuseIdentifer)
        
        self.refreshFeed()
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
        let tableViewCell = tableView.dequeueReusableCellWithIdentifier(self.subgenreReuseIdentifer, forIndexPath: indexPath) as UITableViewCell
        tableViewCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        let mediaEntry = self.mediaEntries[indexPath.row];
        
        if let name = mediaEntry.name {
            tableViewCell.textLabel?.text = name
        }
        
        return tableViewCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let mediaEntry = self.mediaEntries[indexPath.row]
        let viewController = DetailViewController(mediaEntry: mediaEntry);
        self.navigationController?.pushViewController(viewController, animated: true);
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
}

