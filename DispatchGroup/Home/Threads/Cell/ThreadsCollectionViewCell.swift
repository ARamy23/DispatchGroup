//
//  ThreadsCollectionViewCell.swift
//  DispatchGroup
//
//  Created by Ahmed Ramy on 6/10/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

protocol CellSelectionDelegate: class
{
    func didTapCell(model: Decodable)
}

class ThreadsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var threadsTableView: UITableView!
    
    var threads = Thread()
    
    weak var delegate: CellSelectionDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        threadsTableView.delegate = self
        threadsTableView.dataSource = self
        threadsTableView.register(UINib(nibName: "ThreadsTableViewCell", bundle: nil), forCellReuseIdentifier: "ThreadsTableViewCell")
    }

    func setModel(model: Thread)
    {
        threads = model
        threadsTableView.reloadData()
    }
    
}

extension ThreadsCollectionViewCell: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return threads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = threadsTableView.dequeueReusableCell(withIdentifier: "ThreadsTableViewCell", for: indexPath) as! ThreadsTableViewCell
        cell.setModel(model: threads[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapCell(model: threads[indexPath.row])
    }
    
}
