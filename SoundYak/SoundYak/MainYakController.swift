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
    var votedAlready:NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let uniqueTemp:NSArray! = [41,13,32,2,75,43,76,3453,321,453]
        let postnamesTemp:NSArray! = ["JackU: take u there", "Bondax: Kiesza remixes", "James Brown: I invented funk", "Fatboy slim: Weapon of choice more walken edition", "Liquicity: mix tape 2","JackU: take u there", "Bondax: Kiesza remixes", "James Brown: I invented funk", "Fatboy slim: Weapon of choice more walken edition", "Liquicity: mix tape 2"]
        let timestampTemp:NSArray! = ["45s", "12m", "5h", "7m", "2d","45s", "12m", "5h", "7m", "2d"]
        let tagsTemp:NSArray! = [["$hype","$trill","$maddecent"],["$garage","$chill","$skylinevibe"],["$royal"],["$walken"],["$transcend","$soul"],["$hype","$trill","$maddecent"],["$garage","$chill","$skylinevibe"],["$royal"],["$walken"],["$transcend","$soul"]]
        let upvoteTemp:NSArray! = [132,24,10,2120,5,132,24,10,2120,5]
        let downvoteTemp:NSArray! = [12,2,18,1209,0,12,2,18,1209,0]
        
        var cnt = postnamesTemp.count
        for idx in 0...(cnt-1)
        {
            NSLog("creating and converting \(idx)")
            var tempDict:NSDictionary! = NSDictionary(objects:[postnamesTemp[idx],timestampTemp[idx],tagsTemp[idx],upvoteTemp[idx],downvoteTemp[idx], uniqueTemp[idx]], forKeys: ["postname","timestamp","tags","upvotes","downvotes","songid"])
            var yak:YakPostObject = initWithAJSONObject(tempDict)
            NSLog("appending to page data")
            sampleTableViewData.addObject(yak)
        }
        
        var fMan:NSFileManager = NSFileManager.defaultManager()
        
        var paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        var checkedAlreadyPath = paths.stringByAppendingString("votedalready.plist")
        if fMan.fileExistsAtPath(checkedAlreadyPath)
        {
            self.votedAlready = NSMutableArray(contentsOfFile: checkedAlreadyPath)!
        }
        else
        {
            self.votedAlready = NSMutableArray(array: [])
            self.votedAlready.writeToFile(checkedAlreadyPath, atomically: true)
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
        return sampleTableViewData.count
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
        
        cell.fleekVoteButton.tag = indexPath.row
        cell.laameVoteButton.tag = indexPath.row
        
        if (self.votedAlready.containsObject(yak.songid))
        {
            //DO NOTHING
            NSLog("already voted the song")
        }
        else
        {
            cell.fleekVoteButton.setImage(UIImage(named: "upvote"), forState: UIControlState.Normal)
            cell.laameVoteButton.setImage(UIImage(named: "downvote"), forState: UIControlState.Normal)
            cell.laameVoteButton.enabled = true
            cell.fleekVoteButton.enabled = true
        }
        
        //cell.webView = UIWebView(frame: CGRect(x: 5, y: <#CGFloat#>, width: <#CGFloat#>, height: <#CGFloat#>))
        
        return cell
    }
    
    @IBAction func upvoteSong(button:UIButton)
    {
        var indexPath:NSIndexPath = NSIndexPath(forRow: button.tag, inSection: 0)
        var cell:YakTableViewCell = YakTableView.cellForRowAtIndexPath(indexPath) as YakTableViewCell
        cell.fleekVoteButton.setImage(UIImage(named: "upvoteSelected"), forState: UIControlState.Normal)
        cell.laameVoteButton.enabled = false
        cell.fleekVoteButton.enabled = false
        var yak:YakPostObject = sampleTableViewData[button.tag] as YakPostObject
        self.votedAlready.addObject(yak.songid)
    }
    
    @IBAction func downvoteSong(button:UIButton)
    {
        var indexPath:NSIndexPath = NSIndexPath(forRow: button.tag, inSection: 0)
        var cell:YakTableViewCell = YakTableView.cellForRowAtIndexPath(indexPath) as YakTableViewCell
        cell.laameVoteButton.setImage(UIImage(named: "downvoteSelected"), forState: UIControlState.Normal)
        cell.laameVoteButton.enabled = false
        cell.fleekVoteButton.enabled = false
        var yak:YakPostObject = sampleTableViewData[button.tag] as YakPostObject
        self.votedAlready.addObject(yak.songid)
    }

}
