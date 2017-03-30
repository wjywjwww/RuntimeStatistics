//
//  OneViewController.swift
//  RunTime统计
//
//  Created by sks on 17/3/1.
//  Copyright © 2017年 besttone. All rights reserved.
//

import UIKit

class OneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func popClick(_ sender: UIButton) {
        _ =  self.navigationController?.popViewController(animated: true)
    }
    @IBAction func pushClick(_ sender: UIButton) {
        self.performSegue(withIdentifier: "onePushToThree", sender: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
