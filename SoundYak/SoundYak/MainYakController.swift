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
    @IBOutlet var filterSegmentedControl: UISegmentedControl!
    @IBOutlet var composePostButton: UIBarButtonItem!
    
    var sampleTableViewData:NSMutableArray! = NSMutableArray()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let postnamesTemp:NSArray! = ["JackU: take u there", "Bondax: Kiesza remixes", "James Brown: I invented funk", "Fatboy slim: Weapon of choice more walken edition", "Liquicity: mix tape 2"]
        let timestampTemp:NSArray! = ["45s", "12m", "5h", "7m", "2d"]
        let tagsTemp:NSArray! = [["$hype","$trill","$maddecent"],["$garage","$chill","$skylinevibe"],["$royal"],["$walken"],["$transcend","$soul"]]
        let upvoteTemp:NSArray! = [132,24,10,2120,5]
        let downvoteTemp:NSArray! = [12,2,18,1209,0]
        
        for idx in 0...4
        {
            NSLog("creating and converting \(idx)")
            var tempDict:NSDictionary! = NSDictionary(objects:[postnamesTemp[idx],timestampTemp[idx],tagsTemp[idx],upvoteTemp[idx],downvoteTemp[idx]], forKeys: ["postname","timestamp","tags","upvotes","downvotes"])
            var yak:YakPostObject = initWithAJSONObject(tempDict)
            NSLog("appending to page data")
            sampleTableViewData.addObject(yak)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    func numberOfSectionsInTableView(tableView: UITableView) -> Int! {
        return 1
    }
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("yakCell", forIndexPath: indexPath) as YakTableViewCell
        
        NSLog("a cell made")// with %@",sampleTableViewData.objectAtIndex(indexPath.row) as YakPostObject)
        var yak:YakPostObject! = sampleTableViewData[indexPath.row] as YakPostObject
        cell.postNameLabel.text = yak.postName
        
        var netVotes:NSInteger = (yak.upvotes - yak.downvotes) as NSInteger
        cell.netVotesLabel.text = NSString(format: "%ld", netVotes)
        
        cell.timeStampLabel.text = yak.timestamp
        
        var tagCombined:NSMutableString = NSMutableString()
        var dataL:NSInteger = yak.tags.count
        for var idx = 0; idx < dataL; ++idx
        {
            NSLog("string count \(idx)")
            var str = yak.tags[idx] as String
            tagCombined.appendString(str)
        }
        cell.tagsLabel.text = tagCombined
        
        
        return cell
    }

}
