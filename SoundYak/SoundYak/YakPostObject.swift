//
//  YakPostObject.swift
//  SoundYak
//
//  Created by Michael Zuccarino on 11/25/14.
//  Copyright (c) 2014 Michael Zuccarino. All rights reserved.
//

import UIKit

class YakPostObject: NSObject {
    
    var originalJSON:NSDictionary!
    var postName:NSString!
    var upvotes:NSInteger!
    var downvotes:NSInteger!
    var tags:NSArray!
    var timestamp:NSString!
    var songid:NSInteger!
    var posturl:NSString!
}

func initWithAJSONObject(jsonObj:NSDictionary!) -> YakPostObject
{
    var yak:YakPostObject! = YakPostObject()
        NSLog("read JSON %@",jsonObj.valueForKey("postname")as NSString)
    NSLog("creating yak post object %@", jsonObj)
    yak.originalJSON = jsonObj
    NSLog("set original json")
    yak.postName = jsonObj.valueForKey("postname") as NSString
    NSLog("read postname")
    yak.upvotes = jsonObj.valueForKey("upvotes") as NSInteger
    NSLog("read upvotes")
    yak.downvotes = jsonObj.valueForKey("downvotes") as NSInteger
    NSLog("read downvotes")
    yak.tags = jsonObj.objectForKey("tags") as NSArray
    NSLog("read tags")
    yak.timestamp = jsonObj.valueForKey("timestamp") as NSString
    NSLog("read timestamp")
    yak.songid = jsonObj.valueForKey("songid") as NSInteger
    yak.posturl = jsonObj.valueForKey("posturl") as NSString
    NSLog("finished conforming json object, finalstruct:\n%@",yak)
    return yak
}