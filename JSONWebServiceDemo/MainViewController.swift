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
    var genres: [GenreModel] = Array()
    var genreManager: GenreManager
    let genreReuseIdentifer: String = "genreReuseIdentifer"
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.genreManager = GenreManager()
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: self.genreReuseIdentifer)
        
        self.title = "iTunes Music Genres"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        self.refreshFeed()
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    
    //MARK: - UITableViewDataSource, UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return genres.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres[section].subgenres.count;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let genre = self.genres[section]
        return genre.name
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCellWithIdentifier(self.genreReuseIdentifer, forIndexPath: indexPath) as UITableViewCell
        tableViewCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        let genre = self.genres[indexPath.section]
        let subgenre = genre.subgenres[indexPath.row]
        
        if let name = subgenre.name {
            tableViewCell.textLabel?.text = name
        }
        
        return tableViewCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let genre = self.genres[indexPath.section]
        let subgenre = genre.subgenres[indexPath.row]
        
        let viewController = SubgenreViewController(subgenre: subgenre)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        return 1;
    }
    
    func refreshFeed() {
        self.genreManager.getMusicGenres { (results) -> Void in
            self.genres = results
            self.reloadTable()
        }
    }
    
    private func reloadTable() {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.tableView.reloadData()
        }
    }
}
