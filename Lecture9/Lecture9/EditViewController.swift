//
//  EditViewController.swift
//  Lecture9
//
//  Created by tinaun on 7/20/16.
//  Copyright © 2016 tinaun. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
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
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
