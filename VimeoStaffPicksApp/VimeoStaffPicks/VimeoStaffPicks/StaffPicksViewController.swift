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
    
    let items = ["alfie","lee","mattan","syd","zach", "adlknsadlknsaldknaslkdnasdlnsaldknas"]
    
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
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(ViewCell.self)) as! ViewCell
        
        cell.nameLabel?.text = self.items[indexPath.row]

        
        return cell
    }
    
    func refreshItems() {
        VimeoClient.staffpicks { (object, error) -> Void in
            println("error: \(error) \n object: \(object) ")
        }
    }
    
}
