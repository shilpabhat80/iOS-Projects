//
//  CMBPersonCollectionViewCell.swift
//  CMBTeam
//
//  Created by Shilpa Bhat on 26/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class CMBPersonCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    
    func updateView(withPerson person:CMBPerson) {
        nameLabel.text = "\(person.firstName) \(person.lastName)"
        jobTitleLabel.text = person.title
        bioTextView.text = person.bio
    }
}
