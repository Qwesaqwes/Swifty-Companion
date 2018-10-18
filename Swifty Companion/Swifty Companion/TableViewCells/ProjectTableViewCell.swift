//
//  ProjectTableViewCell.swift
//  Swifty Companion
//
//  Created by Jimmy CHEN-MA on 10/17/18.
//  Copyright © 2018 Jimmy CHEN-MA. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell
{

    @IBOutlet weak var projectText: UILabel!
    
    
    func displayProject(project: Project)
    {
//        print (project.validated as Any)
        if let score = project.final_mark
        {
            if score >= 50
            {
                self.backgroundColor = UIColor.green.withAlphaComponent(0.2)
            }
            else
            {
                self.backgroundColor = UIColor.red.withAlphaComponent(0.2)
            }
            projectText.text = String(describing: String(project.project.name) + " - " + String(score) + "%")
        }
        else
        {
            self.backgroundColor = UIColor.white.withAlphaComponent(1)
            projectText.text = String(describing: String(project.project.name) + " - No Mark")
        }
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
