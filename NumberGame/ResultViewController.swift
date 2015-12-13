//
//  ResultViewController.swift
//  NumberGame
//
//  Created by yusuke_kimoto on 2015/12/12.
//  Copyright © 2015年 yusuke kimoto. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var resultScoreLabel: UILabel!
    
    var resultScore = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        resultScoreLabel.text = String(resultScore)

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func tapResultButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            print("戻るボタンが押されました")
        }
    }

}