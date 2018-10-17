//
//  SkillTableViewCell.swift
//  Swifty Companion
//
//  Created by Jimmy CHEN-MA on 10/17/18.
//  Copyright © 2018 Jimmy CHEN-MA. All rights reserved.
//

import UIKit

class SkillTableViewCell: UITableViewCell
{
    @IBOutlet weak var skillText: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    func displaySkill(skill:Skill)
    {
        skillText.text = String(describing: String(skill.name) + " - " + String(skill.level) + "%")
        progressBar.progress = Float(skill.level) / 21.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
