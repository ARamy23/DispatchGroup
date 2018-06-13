//
//  ViewController.swift
//  DispatchGroup
//
//  Created by Ahmed Ramy on 6/6/18.
//  Copyright © 2018 Ahmed Ramy. All rights reserved.
//

import UIKit




class HomeViewController: UIViewController
{

    @IBOutlet weak var homeDashboardCollectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    
    var threads = Thread()
    var vouchers = [Voucher]()
    var selectedThread: ThreadElement?
    var selectedVoucher: Voucher?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startDownload()
        setupDashboard()
    }
    
    fileprivate func setupDashboard()
    {
        homeDashboardCollectionView.register(UINib(nibName: "VouchersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VouchersCollectionViewCell")
        homeDashboardCollectionView.register(UINib(nibName: "ThreadsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ThreadsCollectionViewCell")
        homeDashboardCollectionView.dataSource = self
        homeDashboardCollectionView.delegate = self
    }
    
    fileprivate func getThreads(_ group: DispatchGroup) {
        let threadsHeaders = ["deviceid": "8a66abce571674f8" ,
                              "token": "efT8-ORohzo:APA91bHSHHP5jEoRxax4KXYbJN8pUO_B6SX-iazDVeJ74cxHe6FP3nMGOHUYE2ZjrPT7Pmc39MTmZVCe3dwiX_lAaIjoUw7vh6mJvimeswXb-pwGLvM6N4Ho-8iii7LepT-cJy27VCYd",
                              "APP-ID":"com.coral.kempton"]
        group.enter()
        APIManager().getData(endpoint: Constants.threadsExtension.rawValue, method: HTTPMethod.get, params: nil, headers: threadsHeaders, model: Thread.self) { (threads, response, error) in
            
            group.leave()
            if error != nil
            {
                self.showAlert(title: "Error", message: error!.localizedDescription)
                print(error?.localizedDescription.debugDescription ?? "error")
                return
            }
            
            if let threads = threads
            {
                self.threads = threads
            }
        }
    }
    
    fileprivate func getVouchers(_ group: DispatchGroup) {
        group.enter()
        APIManager().getData(endpoint: Constants.voucherExtension.rawValue, method: HTTPMethod.get, params: nil, headers: nil, model: [Voucher].self) { (vouchers, response, error) in
            group.leave()
            if error != nil
            {
                self.showAlert(title: "Error", message: error!.localizedDescription)
            }
            
            if let vouchers = vouchers
            {
                self.vouchers = vouchers
            }
        }
    }
    
    fileprivate func startDownload() {
        if Reachability.isConnectedToNetwork()
        {
            let progressHUD = ProgressHUD(text: "Downloading")
            self.view.addSubview(progressHUD)
            
            let group = DispatchGroup()
            
            getThreads(group)
            
            getVouchers(group)
            
            group.notify(queue: .main) {
                progressHUD.hide()
                self.homeDashboardCollectionView.reloadData()
            }
        }
        else
        {
            showAlert(title: "No Connection", message: "please check your connection")
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0
        {
            let cell = homeDashboardCollectionView.dequeueReusableCell(withReuseIdentifier: "ThreadsCollectionViewCell", for: indexPath) as! ThreadsCollectionViewCell
            cell.setModel(model: self.threads)
            cell.backgroundColor = .red
            cell.delegate = self
            return cell 
        }
        else if indexPath.row == 1
        {
            let cell = homeDashboardCollectionView.dequeueReusableCell(withReuseIdentifier: "VouchersCollectionViewCell", for: indexPath) as! VouchersCollectionViewCell
            cell.setModel(model: self.vouchers)
            cell.backgroundColor = .red
            cell.delegate = self
            return cell
        }
        
        let cell = UICollectionViewCell()
        cell.backgroundView?.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: self.view.frame.width, height: containerView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 0
        {
            navigationController?.navigationBar.topItem?.title = "Threads"
        }
        else if indexPath.row == 1
        {
            navigationController?.navigationBar.topItem?.title = "Vouchers"
        }
    }
}

extension HomeViewController: CellSelectionDelegate
{
    func didTapCell(model: Decodable) {
        if let modelOfThreads = model as? ThreadElement
        {
            selectedThread = modelOfThreads
        }
        else if let modelOfVouchers = model as? Voucher
        {
            selectedVoucher = modelOfVouchers
        }
        else
        {
            fatalError("try a different approach")
        }
        performSegue(withIdentifier: Navigation.goToDetails.rawValue, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController
        {
            if selectedVoucher != nil
            {
                destination.setModelIfVouchersClicked(model: selectedVoucher!)
            }
            else if selectedThread != nil
            {
                destination.setModelIfThreadsClicked(model: selectedThread!)
            }
        }
    }
}

extension UIViewController
{
    func showAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        DispatchQueue.main.async {self.present(alert, animated: true, completion: nil)}
    }
}


import UIKit

class ProgressHUD: UIVisualEffectView {
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    let label: UILabel = UILabel()
    let blurEffect = UIBlurEffect(style: .light)
    let vibrancyView: UIVisualEffectView
    
    init(text: String) {
        self.text = text
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(effect: blurEffect)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.text = ""
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup() {
        contentView.addSubview(vibrancyView)
        contentView.addSubview(activityIndictor)
        contentView.addSubview(label)
        activityIndictor.startAnimating()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let superview = self.superview {
            
            let width = superview.frame.size.width / 2.3
            let height: CGFloat = 50.0
            self.frame = CGRect(x: superview.frame.size.width / 2 - width / 2,
                                y: superview.frame.height / 2 - height / 2,
                                width: width,
                                height: height)
            vibrancyView.frame = self.bounds
            
            let activityIndicatorSize: CGFloat = 40
            activityIndictor.frame = CGRect(x: 5,
                                            y: height / 2 - activityIndicatorSize / 2,
                                            width: activityIndicatorSize,
                                            height: activityIndicatorSize)
            
            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            label.text = text
            label.textAlignment = NSTextAlignment.center
            label.frame = CGRect(x: activityIndicatorSize + 5,
                                 y: 0,
                                 width: width - activityIndicatorSize - 15,
                                 height: height)
            label.textColor = UIColor.gray
            label.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
}
