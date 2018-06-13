//
//  ThreadsTableViewCell.swift
//  DispatchGroup
//
//  Created by Ahmed Ramy on 6/10/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

protocol didSelectACellInTableViewDelegate: class
{
    func didTapOnCell(model: Decodable)
}

class ThreadsTableViewCell: UITableViewCell {

    @IBOutlet weak var drNameLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    weak var delegate: didSelectACellInTableViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        roundifyTheCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate func roundifyTheCell()
    {
        containerView.layer.cornerRadius = 16
        containerView.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        containerView.layer.borderWidth = 0.75
        
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        containerView.layer.shadowOpacity = 10
        containerView.layer.shadowOffset = CGSize(width: 1, height: 1)
        containerView.layer.shadowRadius = 10
    }
    
    func setModel(model: ThreadElement)
    {
        drNameLbl.text = model.tpaName
    }
    
}
