//
//  ForecastTableViewCell.swift
//  LotteryForecast
//
//  Created by Soohan Lee on 2019/11/20.
//  Copyright © 2019 Soohan. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var ballStackView: UIStackView!
    
    @IBOutlet weak var firstBall: UILabel!
    @IBOutlet weak var secondBall: UILabel!
    @IBOutlet weak var thirdBall: UILabel!
    @IBOutlet weak var fourthBall: UILabel!
    @IBOutlet weak var fifthBall: UILabel!
    @IBOutlet weak var sixthBall: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
