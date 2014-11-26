//
//  MainYakController.swift
//  SoundYak
//
//  Created by Michael Zuccarino on 11/25/14.
//  Copyright (c) 2014 Michael Zuccarino. All rights reserved.
//
import UIKit

class MainYakController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet var YakTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("yakCell", forIndexPath: indexPath) as UITableViewCell
        return cell
    }

}
