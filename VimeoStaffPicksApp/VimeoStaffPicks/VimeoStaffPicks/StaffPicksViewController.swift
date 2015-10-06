//
//  StaffPicksViewController.swift
//  VimeoStaffPicks
//
//  Created by Matthew Weintrub on 10/2/15.
//  Copyright (c) 2015 matthew weintrub. All rights reserved.
//

import UIKit

class StaffPicksViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView?
    
    var items: Array<Video> = []
    
    //mark: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        
        self.title = "Staff Picks"
        
        self.setUpTableView()
        
        self.refreshItems()
    }

    // mark: SETUP
    
    func setUpTableView() {
        
        let nib = UINib(nibName: "ViewCell", bundle: nil)
        self.tableView?.registerNib(nib, forCellReuseIdentifier: NSStringFromClass(ViewCell.self))
    }
    
    // mark: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //returns number of rows needed per data returned
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //source of location that provides data to table
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(ViewCell.self)) as! ViewCell
        
        //get the video and let the cell configure itself
        let video = self.items[indexPath.row]
        cell.video = video
                
        return cell
    }
    
    func refreshItems() {
        VimeoClient.staffpicks { (videos, error) -> Void in
       
            //if constVideo is equal to videos then...
            if let constVideos = videos {
                
               //make it equal to list of videos we return from api
               self.items = constVideos
            
                //table view refresh to load new data returned into cells
                self.tableView?.reloadData()
            }
        }
    }
    
}
