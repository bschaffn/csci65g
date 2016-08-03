//
//  ViewController.swift
//  Lecture10
//
//  Created by tinaun on 7/25/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var urlField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        urlField.text = "api.openweathermap.org/data/2.5/weather?q=boston, ma&appid=77e555f36584bc0c3d55e1e584960580"
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fetch(sender: AnyObject) {
        let text = "http://\(urlField.text!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet(charactersInString: " \"").invertedSet)!)"
        
        print(text)
        
        let url = NSURL(string: text)!
        
        let fetcher = Fetcher()
        fetcher.requestJSON(url) { (json, message) in
            let op = NSBlockOperation {
                if let json = json as? NSObject {
                    self.textView.text = json.description
                } else if let message = message {
                    self.textView.text = message
                } else {
                    self.textView.text = "Invalid JSON."
                }
            }
            
            NSOperationQueue.mainQueue().addOperation(op)
        }
            
    }

}

