//
//  PostViewController.swift
//  SoundYak
//
//  Created by Michael Zuccarino on 11/25/14.
//  Copyright (c) 2014 Michael Zuccarino. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UITextFieldDelegate, UIWebViewDelegate {
    
    @IBOutlet var quickDisplay:UIWebView!
    @IBOutlet var postButton:UIButton!
    @IBOutlet var linkField:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        
    }
    
    override func viewDidAppear(animated: Bool) {
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.quickDisplay.delegate = self
        var specifiedURL:NSURL = NSURL(string: textField.text)!
        quickDisplay.loadRequest(NSURLRequest(URL: specifiedURL))
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if (textField.text.isEmpty)
        {
            textField.text = UIPasteboard.generalPasteboard().string
            self.quickDisplay.delegate = self
            var specifiedURL:NSURL = NSURL(string: textField.text)!
            quickDisplay.loadRequest(NSURLRequest(URL: specifiedURL))
            return false
        }
        else
        {
            return true
        }
        
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        UIView.animateWithDuration(1.5, animations: {
            self.postButton.layer.cornerRadius = 15
            self.postButton.clipsToBounds = true
            self.postButton.layer.borderColor = UIColor(red: 1, green: 0, blue:0 , alpha: 1).CGColor
            self.postButton.layer.borderWidth = 1
            self.postButton.titleLabel?.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1);
            self.postButton.enabled = false
        })
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIView.animateWithDuration(1.5, animations: {
            self.postButton.layer.cornerRadius = 15
            self.postButton.clipsToBounds = true
            self.postButton.layer.borderColor = UIColor(red: 0, green: 1, blue: 0.31, alpha: 1).CGColor
            self.postButton.layer.borderWidth = 1
            self.postButton.titleLabel?.textColor = UIColor(red: 0, green: 1, blue: 0.31, alpha: 1);
            self.postButton.enabled = true
        })
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        UIView.animateWithDuration(1.5, animations: {
            self.postButton.layer.cornerRadius = 15
            self.postButton.clipsToBounds = true
            self.postButton.layer.borderColor = UIColor(red: 0, green: 0.678, blue: 1, alpha: 1).CGColor
            self.postButton.layer.borderWidth = 1
            self.postButton.titleLabel?.textColor = UIColor(red: 0, green: 0.678, blue: 1, alpha: 1);
            self.postButton.enabled = true
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
