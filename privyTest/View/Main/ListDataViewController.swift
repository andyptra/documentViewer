//
//  ListDataViewController.swift
//  privyTest
//
//  Created by andyptra on 5/27/20.
//  Copyright © 2020 andyptra. All rights reserved.
//

import UIKit

class ListDataViewController: UIViewController,PdfViewModelDelegate {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var tableViewData: UITableView!
    
    var viewModel = PdfViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getListData()
        self.setupTableView()
    }
    func reloadTable() {
            self.tableViewData.reloadData()
    }
}


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
        //        //        selectedOffersIndex = indexPath.row
        //        let vc = PhotosViewController()
        //        self.navigationController?.pushViewController(vc, animated: false)
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
