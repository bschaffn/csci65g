//
//  LoaderViewController.swift
//  FinalProject
//
//  Created by tinaun on 8/3/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import UIKit

class LoaderViewController: UIViewController {
    var pattern: Pattern?
    var urlForPattern: NSURL?
    var commit: ((Pattern, NSURL) -> Void)?
    
    
    @IBOutlet weak var previewFile: UIButton!
    @IBOutlet weak var patternURL: UITextField!
    @IBOutlet weak var patternData: UITextView!
    @IBOutlet weak var patternGrid: GridView!
    @IBOutlet weak var loadButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.setNavigationBarHidden(false, animated: true)
        
        patternURL.text = urlForPattern!.description
        patternGrid.grid = Grid(rows: 1, cols: 1)
        self.loadButton.enabled = false
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loadPattern(sender: AnyObject) {
        if let commit = commit {
            if let pattern = self.pattern {
                commit(pattern, urlForPattern!)
                
                navigationController?.popViewControllerAnimated(true)
            } else {
                let alert = UIAlertController(title: "Invalid", message: "File is not readable as RLE", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    
                    }
                    
                alert.addAction(defaultAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func fetchRLE(sender: AnyObject) {
        let text = patternURL.text!
        
        urlForPattern = NSURL(string: text)
        
        if let path = urlForPattern!.pathExtension {
            let fetcher = Fetcher()
            
            if path == "rle" {
                fetcher.requestRLE(urlForPattern!) { (rle, message) in
                    let op = NSBlockOperation {
                        if let rle = rle {
                            self.patternGrid.grid = rle.data
                            
                            self.pattern = rle
                            
                            var text = "\(rle.metadata.name)\n"
                            text += "\n \(rle.metadata.owner)\n"
                            let _ = rle.metadata.comments.map {
                                text += "\($0)\n"
                            }
                            
                            self.patternData.text = text
                            self.loadButton.enabled = true
                        } else if let message = message {
                            self.patternData.text = message
                        } else {
                            self.patternData.text = "Invalid RLE File."
                        }
                    }

                    NSOperationQueue.mainQueue().addOperation(op)
                }
            } else {
                patternData.text = "Invalid extension \(path)"
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
