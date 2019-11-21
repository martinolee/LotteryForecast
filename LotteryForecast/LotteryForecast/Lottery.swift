//
//  Lottery.swift
//  LotteryForecast
//
//  Created by Soohan Lee on 2019/11/21.
//  Copyright © 2019 Soohan. All rights reserved.
//

import Foundation
import UIKit

class Lottery {
    var forecastList = Array<[Int]>()
    
    func makeNumbers() -> [Int] {
        var lotteryNumbers = Array<Int>()
        
        for lotteryNumber in 1 ... 45 { lotteryNumbers.append(lotteryNumber) }
        
        lotteryNumbers = lotteryNumbers.shuffled()
        lotteryNumbers = Array(lotteryNumbers.dropLast(39))
        lotteryNumbers = lotteryNumbers.sorted()
        
        return lotteryNumbers
    }
}

enum LotteryBall {
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
