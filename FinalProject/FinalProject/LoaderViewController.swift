//
//  LoaderViewController.swift
//  FinalProject
//
//  Created by tinaun on 8/3/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import UIKit

class LoaderViewController: UIViewController {

    @IBOutlet weak var previewFile: UIButton!
    @IBOutlet weak var patternURL: UITextField!
    @IBOutlet weak var patternData: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.setToolbarHidden(false, animated: true)
        
        patternURL.text = "http://www.conwaylife.com/patterns/gardenofeden1.rle"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fetchRLE(sender: AnyObject) {
        let text = patternURL.text!
        
        let url = NSURL(string: text)!
        
        if let path = url.pathExtension {
            let fetcher = Fetcher()
            
            if path == "rle" {
                fetcher.requestRLE(url) { (rle, message) in
                    let op = NSBlockOperation {
                        if let rle = rle {
                            var text = rle.data.description
                            text += "\n \(rle.metadata.name)\n"
                            text += "\n \(rle.metadata.owner)\n"
                            text += "\n \(rle.metadata.comments)\n"
                            
                            self.patternData.text = text
                        } else if let message = message {
                            self.patternData.text = message
                        } else {
                            self.patternData.text = "Invalid RLE File."
                        }
                    }

                    NSOperationQueue.mainQueue().addOperation(op)
                }
            } else {
                    
            }
        } else {
            patternData.text = "No Extension!"
        }
        
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
