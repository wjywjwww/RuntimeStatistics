//
//  ViewController.swift
//  RunTime统计
//
//  Created by sks on 17/3/1.
//  Copyright © 2017年 besttone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
       
    }
    @IBAction func presentClick(_ sender: UIButton) {
        self.performSegue(withIdentifier: "presentToOne", sender: nil)
    }
}

