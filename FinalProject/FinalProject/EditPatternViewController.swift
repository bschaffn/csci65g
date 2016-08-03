//
//  EditPatternViewController.swift
//  FinalProject
//
//  Created by tinaun on 8/3/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import UIKit

class EditPatternViewController: UIViewController {
    
    var name: String?
    var commit: (String -> Void)?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var submitButton: UIBarButtonItem!
    
    @IBAction func save(sender: AnyObject) {
        guard let newText = nameTextField.text, commit = commit
            else {return} // should be an error
        
        commit(newText)
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = name {
            nameTextField.text = name
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
