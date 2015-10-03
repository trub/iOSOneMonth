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
    
    let items = ["alfie","lee","mattan","syd","zach"]
    
    //mark: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        
        self.setUpTableView()
    }

    // mark: SETUP
    
    func setUpTableView() {
        
        self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "placeholder")
        
    }
    
    // mark: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("placeholder") as! UITableViewCell
        
        cell.textLabel?.text = self.items[indexPath.row]

        
        return cell
    }
    
}
