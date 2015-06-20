//
//  ViewController.swift
//  Backtrack
//
//  Created by Arnaud Mesureur on 11/05/15.
//  Copyright (c) 2015 Arnaud Mesureur. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var codeField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.codeField.delegate = self
        self.codeField.text = "021000620241"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowBacktrackSegue" {
            if let destinationVC = segue.destinationViewController as? BacktrackViewController {
                destinationVC.code = self.codeField.text
            }
        }
    }

}
