//
//  VouchersCollectionViewCell.swift
//  DispatchGroup
//
//  Created by Ahmed Ramy on 6/10/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit



class VouchersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var vouchersTableView: UITableView!
    
    var vouchers = [Voucher]()
    var delegate: CellSelectionDelegate?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        vouchersTableView.dataSource = self
        vouchersTableView.delegate = self
        vouchersTableView.register(UINib(nibName: "VouchersTableViewCell", bundle: nil), forCellReuseIdentifier: "VouchersTableViewCell")
        vouchersTableView.estimatedRowHeight = 150
        vouchersTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    func setModel(model: [Voucher])
    {
        vouchers = model
        vouchersTableView.reloadData()
    }
    

}

extension VouchersCollectionViewCell: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vouchers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = vouchersTableView.dequeueReusableCell(withIdentifier: "VouchersTableViewCell", for: indexPath) as! VouchersTableViewCell
        cell.setModel(model: vouchers[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapCell(model: vouchers[indexPath.row])
    }
    
    
}
