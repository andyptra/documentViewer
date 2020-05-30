//
//  ListDataViewController.swift
//  privyTest
//
//  Created by andyptra on 5/27/20.
//  Copyright © 2020 andyptra. All rights reserved.
//

import UIKit
import PDFKit
class ListDataViewController: UIViewController, PdfViewModelDelegate {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var tableViewData: UITableView!
    var activityView: UIActivityIndicatorView?
    var viewModel = PdfViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List Data";
        self.fetchData()
        self.setupTableView()
    }
    
    // MARK : func delegate reload data
    func reloadTable() {
        self.tableViewData.reloadData()
    }
    
    // MARK: - Networking
    private func fetchData() {
        viewModel.getListData()
        viewModel.delegate = self
        viewModel.updateLoadingStatus = {
            let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        
        viewModel.showAlert = {
            if let error = self.viewModel.error {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - UI Setup Indicator
    private func activityIndicatorStart() {
        activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView?.color = UIColor.red
        activityView?.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
        activityView?.center = self.view.center
        self.view.bringSubviewToFront(activityView!)
        activityView?.startAnimating()
    }
    
    // MARK: - UI Stop Indicator
    private func activityIndicatorStop() {
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
}

// MARK : tableview delegate and data source
extension ListDataViewController :  UITableViewDelegate, UITableViewDataSource {
    func setupTableView(){
        tableViewData.register(ListDataTableViewCell.nib(), forCellReuseIdentifier: "cell")
        tableViewData.delegate = self
        tableViewData.dataSource = self
        tableViewData.separatorStyle = .none
        tableViewData.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
            return viewModel.dataItems.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PdfViewController()
        
        vc.urlString = viewModel.dataItems[indexPath.row].file!
        vc.TitleHeader = viewModel.dataItems[indexPath.row].name!
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! ListDataTableViewCell
            
            if viewModel.dataItems.count > 0 {
                let dataItems = viewModel.dataItems[indexPath.row]
                cell.configure(whitViewModel: dataItems.name!)
            }
            cell.selectionStyle = .none
            return cell
    }
}
