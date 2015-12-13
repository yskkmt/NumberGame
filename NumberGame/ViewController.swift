//
//  ViewController.swift
//  NumberGame
//
//  Created by yusuke_kimoto on 2015/12/12.
//  Copyright © 2015年 yusuke kimoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var hanteiLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var evenButton: UIButton!
    @IBOutlet weak var oddButton: UIButton!

    //ラベルにいれる数字
    var randomNumber = arc4random() % 100 + 1
    
    var score = 0
    var countTime = 10
    var timer = NSTimer()
    var startCountDownTime = 3
    
    let titleView = UIView()
    let titleLabel = UILabel()
    let titleButton = UIButton()
    let startCountDownLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //タイトル画面表示
        makeTitleView()
        
        //ボタン装飾
        oddButton.layer.cornerRadius = 6
        evenButton.layer.cornerRadius = 6

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        makeTitleView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //タイトル画面の作成
    func makeTitleView(){
        //タイトルビューの作成
        let rect = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        titleView.frame = rect
        titleView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(titleView)
        //ラベルの作成
        titleLabel.text = "振り分けナンバー"
        titleLabel.sizeToFit()
        titleLabel.center = titleView.center
        titleView.addSubview(titleLabel)
        //ボタンの作成
        titleButton.setTitle("Start!", forState: UIControlState.Normal)
        titleButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        titleButton.backgroundColor = UIColor.blackColor()
        titleButton.sizeToFit()
        titleButton.center = CGPoint(x: titleView.center.x, y: titleLabel.frame.maxY + 60)
        titleButton.addTarget(self, action: "tapTitleButton:", forControlEvents: UIControlEvents.TouchUpInside)
        titleView.addSubview(titleButton)

    }
    
    //タイトルボタンが押された時の処理
    func tapTitleButton(sender: UIButton) {
        print("タイトルボタンが押されました。")
        //初期化
        score = 0
        countTime = 10
        randomNumber = arc4random() % 100 + 1
        
        numberLabel.text = String(randomNumber)
        scoreLabel.text  = String(score)
        scoreLabel.textColor = UIColor.blackColor()
        timeLabel.text   = String(countTime)
        hanteiLabel.text = "スタート!"
        hanteiLabel.textColor = UIColor.blackColor()
        startCountDownTime = 3
        
        //タイトルラベルとタイトルボタンを削除
        titleLabel.removeFromSuperview()
        titleButton.removeFromSuperview()
        
        //スタートカウントダウン開始
        startCountDown()
        //タイトル画面を消す
        //titleView.removeFromSuperview()
        
        //カウントダウン処理
        //timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countdownTimer:", userInfo: nil, repeats: true)
        
        }
    

    //奇数ボタンが押された時の処理
    @IBAction func tapOddButton(sender: UIButton) {
        if randomNumber % 2 == 1 {
            print("奇数ボタン、数字は奇数")
            good()
        } else {
            print("奇数ボタン、数字は偶数")
            miss()
        }
        makeRandomNumber()
    }
    //偶数ボタンが押された時の処理
    @IBAction func tapEvenButton(sender: UIButton) {
        if randomNumber % 2 == 0 {
            print("偶数ボタン、数字は偶数")
            good()
        } else {
            print("偶数ボタン、数字は奇数")
            miss()
        }
        makeRandomNumber()
    }
    
    //ランダムな数をnumberラベルにいれる処理
    func makeRandomNumber() {
        let makeRandomNumber = arc4random() % 100 + 1
        randomNumber = makeRandomNumber
        numberLabel.text = String(randomNumber)
    }
    
    //goodの処理
    func good(){
        hanteiLabel.text = "Good"
        score += 100
        scoreLabel.text = String(score)
        hanteiLabel.textColor = UIColor.redColor()
        scoreLabel.textColor = UIColor.redColor()
    }
    
    //missの処理
    func miss() {
        hanteiLabel.text = "Miss"
        score -= 100
        scoreLabel.text = String(score)
        hanteiLabel.textColor = UIColor.blackColor()
        scoreLabel.textColor = UIColor.blackColor()
    }
    
    //スタートカウントダウンの処理
    func startCountDown(){
        //ラベルの作成
        startCountDownLabel.text = String(startCountDownTime)
        startCountDownLabel.font = UIFont(name: "HiraKakuProN-W6", size: 200)
        startCountDownLabel.sizeToFit()
        startCountDownLabel.center = titleView.center
        titleView.addSubview(startCountDownLabel)
        
        //スタートカウントダウン開始
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "startCountDown:", userInfo: nil, repeats: true)
    }
    
    //スタートカウントダウン
    func startCountDown(startTimer:NSTimer){
        startCountDownTime -= 1
        startCountDownLabel.text = String(startCountDownTime)
        //タイマーが０になったらゲーム開始
        if startCountDownTime == 0 {
            startTimer.invalidate()
            print("ゲーム開始")
            //タイトル画面を消す
            titleView.removeFromSuperview()
            startCountDownLabel.removeFromSuperview()
            
            //カウントダウン処理
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countdownTimer:", userInfo: nil, repeats: true)
            
        }
    }
    
    //カウントダウンタイマー
    func countdownTimer(timer:NSTimer) {
        countTime -= 1
        timeLabel.text = String(countTime)
        //タイマーが0になったらリザルト画面に遷移
        if countTime == 0 {
            timer.invalidate()
            print("終了")
            self.performSegueWithIdentifier("ModalSegue", sender: self)
        }
    }
    
    
    //スコアをリザルト画面に送る
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let ResultViewcontroller = segue.destinationViewController as! ResultViewController
        ResultViewcontroller.resultScore = self.score
    }
}

