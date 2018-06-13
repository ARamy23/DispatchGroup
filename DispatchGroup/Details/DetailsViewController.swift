//
//  DetailsViewController.swift
//  DispatchGroup
//
//  Created by Ahmed Ramy on 6/10/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var voucher: Voucher?
    var thread: ThreadElement?
    
    @IBOutlet weak var detailsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setModelIfVouchersClicked(model: Voucher)
    {
        voucher = model
    }
    
    func setModelIfThreadsClicked(model: ThreadElement)
    {
        thread = model
    }

}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if voucher != nil
        {
            cell.textLabel?.text = voucher?.voucher
            cell.detailTextLabel?.text = "\(voucher?.voucherText ?? "voucher text")\n\(voucher?.provider ?? "provider")\n\(voucher?.doctorName ?? "doctorname")\n\(voucher?.valid_to ?? "valid to") "
            
        }
        else if thread != nil
        {
            cell.textLabel?.text = thread?.tpaName
            cell.detailTextLabel?.text = "If i show, that means the task is done!"
        }
        
        return cell
    }

}
    
    

