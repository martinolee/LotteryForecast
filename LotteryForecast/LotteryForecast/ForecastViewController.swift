//
//  ForecastViewController.swift
//  LotteryForecast
//
//  Created by Soohan Lee on 2019/11/20.
//  Copyright © 2019 Soohan. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    @IBOutlet weak var firstBall: UILabel!
    @IBOutlet weak var secondBall: UILabel!
    @IBOutlet weak var thirdBall: UILabel!
    @IBOutlet weak var fourthBall: UILabel!
    @IBOutlet weak var fifthBall: UILabel!
    @IBOutlet weak var sixthBall: UILabel!
    
    @IBOutlet weak var forecastTableView: UITableView!
    
    var ballList = Array<UILabel>()
    
    var forecastList = Array<[Int]>()
    
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
            // This process makes label look like a ball
        }
        
    }
    
    func makeNumbers() -> [Int] {
        var lotteryNumbers = Array<Int>()
        
        for lotteryNumber in 1...45 { lotteryNumbers.append(lotteryNumber) }
        
        lotteryNumbers = lotteryNumbers.shuffled()
        lotteryNumbers = Array(lotteryNumbers.dropLast(39))
        lotteryNumbers = lotteryNumbers.sorted()
        
        return lotteryNumbers
    }
    
    func changeBallColor(number: Int, ball: UILabel) {
        if (number >= 1 ) && (number <= 10) { ball.backgroundColor = lotteryBall.yellow.color() } else
        if (number >= 11) && (number <= 20) { ball.backgroundColor = lotteryBall.blue  .color() } else
        if (number >= 21) && (number <= 30) { ball.backgroundColor = lotteryBall.red   .color() } else
        if (number >= 31) && (number <= 40) { ball.backgroundColor = lotteryBall.black .color() } else
        if (number >= 41) && (number <= 45) { ball.backgroundColor = lotteryBall.green .color() }
    }
    
    @IBAction func showForecast(_ sender: Any) {
        forecastList.append(makeNumbers())
        
        for index in 0 ..< ballList.count {
            let ball = ballList[index]
            let forecastIndex = forecastList.count - 1
            
            ball.text = "\(forecastList[forecastIndex][index])"
            
            changeBallColor(number: Int(ball.text!)!, ball: ball)
        }
        
        forecastTableView.reloadData()
    }
    
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastList.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell") as! ForecastTableViewCell
        let target = forecastList[indexPath.row]
        
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

enum lotteryBall {
    case yellow, blue, red, black, green
    
    func color() -> UIColor {
        switch self {
        case .yellow: return UIColor(red: 255 / 255, green: 190 / 255, blue: 50  / 255, alpha: 1)
        case .blue  : return UIColor(red: 100 / 255, green: 100 / 255, blue: 255 / 255, alpha: 1)
        case .red   : return UIColor(red: 255 / 255, green: 100 / 255, blue: 100 / 255, alpha: 1)
        case .black : return UIColor(red: 50  / 255, green: 50  / 255, blue: 50  / 255, alpha: 1)
        case .green : return UIColor(red: 90  / 255, green: 200 / 255, blue: 140 / 255, alpha: 1)
        }
    }
}
