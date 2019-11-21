//
//  ForecastViewController.swift
//  LotteryForecast
//
//  Created by Soohan Lee on 2019/11/20.
//  Copyright © 2019 Soohan. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    @IBOutlet weak var firstBall : UILabel!
    @IBOutlet weak var secondBall: UILabel!
    @IBOutlet weak var thirdBall : UILabel!
    @IBOutlet weak var fourthBall: UILabel!
    @IBOutlet weak var fifthBall : UILabel!
    @IBOutlet weak var sixthBall : UILabel!
    
    @IBOutlet weak var forecastTableView: UITableView!
    
    var ballList = Array<UILabel>()
    
    let lottery = Lottery()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
        
        forecastTableView.separatorColor = .clear
        
        ballList.append(firstBall)
        ballList.append(secondBall)
        ballList.append(thirdBall)
        ballList.append(fourthBall)
        ballList.append(fifthBall)
        ballList.append(sixthBall)
        
        for ball in ballList {
            ball.layer.masksToBounds = true
            ball.layer.cornerRadius = ball.layer.frame.width / 2
            // This process makes label looks like a ball
        }
        
    }
    
    func changeBallColor(number: Int, ball: UILabel) {
        if (number > 40) { ball.backgroundColor = LotteryBall.green .color() } else
        if (number > 30) { ball.backgroundColor = LotteryBall.black .color() } else
        if (number > 20) { ball.backgroundColor = LotteryBall.red   .color() } else
        if (number > 10) { ball.backgroundColor = LotteryBall.blue  .color() } else
        if (number > 0 ) { ball.backgroundColor = LotteryBall.yellow.color() }
    }
    
    @IBAction func showForecast(_ sender: Any) {
        lottery.forecastList.append(lottery.makeNumbers())
        
        for index in 0 ..< ballList.count {
            let ball = ballList[index]
            let forecastIndex = lottery.forecastList.count - 1
            
            ball.text = "\(lottery.forecastList[forecastIndex][index])"
            
            changeBallColor(number: Int(ball.text!)!, ball: ball)
        }
        
        forecastTableView.reloadData()
    }
    
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lottery.forecastList.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell") as! ForecastTableViewCell
        let target = lottery.forecastList[indexPath.row]
        
        let deviceWidth = UIScreen.main.bounds.width
        
        let cellBallList: Array<UILabel> = [
            cell.firstBall, cell.secondBall, cell.thirdBall,
            cell.fourthBall, cell.fifthBall, cell.sixthBall
        ]
        
        cell.isUserInteractionEnabled = false
        
        if deviceWidth == 320 { cell.ballStackView.spacing = 23 } else // Small Device e.g. iPhone SE
        if deviceWidth == 375 { cell.ballStackView.spacing = 33 } else // Medium Device e.g. iPhone XS
        if deviceWidth == 414 { cell.ballStackView.spacing = 40 }      // Large Device e.g. iPhone XS Max
        
        for index in 0 ..< cellBallList.count {
            let ball = cellBallList[index]
            ball.text = "\(target[index])"
            
            let ballNumber = Int(ball.text!)!
            
            ball.layer.masksToBounds = true
            ball.layer.cornerRadius = ball.frame.size.width / 2
            
            changeBallColor(number: ballNumber, ball: ball)
        }
        
        return cell
    }
    
}
