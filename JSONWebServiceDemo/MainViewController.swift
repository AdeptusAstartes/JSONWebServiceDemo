//
//  MainViewController.swift
//  JSONWebServiceDemo
//
//  Created by Donald Angelillo on 2/19/16.
//  Copyright © 2016 Donald Angelillo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var mediaEntries: [MediaEntryModel] = Array()
    var feedManager: FeedManager
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.feedManager = FeedManager()
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshFeed();
    }
    
    
    //MARK: - UITableViewDataSource, UITableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaEntries.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "test")
        
        let mediaEntry = self.mediaEntries[indexPath.row]
        
        if let name = mediaEntry.name {
            tableViewCell.textLabel?.text = name
        }
        
        return tableViewCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let mediaEntry = self.mediaEntries[indexPath.row]
        let viewController = DetailViewController(mediaEntry: mediaEntry);
        self.navigationController?.pushViewController(viewController, animated: true);
    }
    
    func refreshFeed() {
        self.feedManager.getTopMovies { (results) -> Void in
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
