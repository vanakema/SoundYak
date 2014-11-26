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
    var expandedPosts:NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let uniqueTemp:NSArray! = [41,13,32,2,75,43,76,3453,321,453]
        let postnamesTemp:NSArray! = ["St.Lucia - Elevate (Audio)", "Star Slinger: Elizabeth Frasier (Cocteau Remix)", "Mungo Jerry: In the summer time", "Skream: Anticipate ft. Sam Frank", "Theophilus London: Figure it out (Disco Razer Remix)", "INSTRUMENTAL: REAL ROCK RIDDIM", "Surfer Interview", "Sugar Minott: Oh Mr DC", "Dex Interview: Torstein"]
        let timestampTemp:NSArray! = ["45s", "12m", "5h", "7m", "2d","45s", "12m", "5h", "7m", "2d"]
        let tagsTemp:NSArray! = [["$hype","$trill","$maddecent"],["$garage","$chill","$skylinevibe"],["$royal"],["$walken"],["$transcend","$soul"],["$hype","$trill","$maddecent"],["$garage","$chill","$skylinevibe"],["$royal"],["$walken"],["$transcend","$soul"]]
        let upvoteTemp:NSArray! = [132,24,10,2120,5,132,24,10,2120,5]
        let downvoteTemp:NSArray! = [12,2,18,1209,0,12,2,18,1209,0]
        let urlTemp:NSArray! = ["http://youtu.be/n-sKMiNqTjs","https://www.youtube.com/watch?v=tqz208BBi6k","https://www.youtube.com/watch?v=kzqRvi8vAvA","https://www.youtube.com/watch?v=yG0oBPtyNb0","https://www.youtube.com/watch?v=tgU0Nw6cZOI","https://www.youtube.com/watch?v=vtvFgSk2_ug","https://www.youtube.com/watch?v=3S7WAcTi1RM","https://www.youtube.com/watch?v=hJdF8DJ70Dc","https://www.youtube.com/watch?v=TCQgB9MFTjE","https://www.youtube.com/watch?v=PiCrjJI3baw"]
        
        var cnt = postnamesTemp.count
        for idx in 0...(cnt-1)
        {
            NSLog("creating and converting \(idx)")
            var tempDict:NSDictionary! = NSDictionary(objects:[postnamesTemp[idx],timestampTemp[idx],tagsTemp[idx],upvoteTemp[idx],downvoteTemp[idx], uniqueTemp[idx], urlTemp[idx]], forKeys: ["postname","timestamp","tags","upvotes","downvotes","songid","posturl"])
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
        
        if (cell.frame.height >= 200)
        {
            cell.webView = UIWebView(frame: CGRectMake(10, 100, self.view.frame.size.width-20, 140))
            var postURL:NSURL = NSURL(string: (sampleTableViewData[indexPath.row] as YakPostObject).posturl)!
            cell.webView.loadRequest(NSURLRequest(URL: postURL))
            cell.contentView.addSubview(cell.webView)
        }
        
        //cell.webView = UIWebView(frame: CGRect(x: 5, y: , width: , height: ))
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if expandedPosts.containsObject(indexPath)
        {
            return 250
        }
        else
        {
            return 104
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        expandedPosts.addObject(indexPath)
        self.YakTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
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
