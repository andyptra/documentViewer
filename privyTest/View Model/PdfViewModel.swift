//
//  PdfViewModel.swift
//  privyTest
//
//  Created by andyptra on 5/27/20.
//  Copyright © 2020 andyptra. All rights reserved.
//

import Foundation


protocol PdfViewModelDelegate: class {
    func reloadTable()
}

class PdfViewModel {
    var dataItems:[Datum] = []
    
    var repository: GetData?
    weak var delegate: PdfViewModelDelegate?
    
    var error: Error? {
        didSet { self.showAlert?() }
    }
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    var showAlert: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    
    init() {
        repository = GetData()
    }
    
    func getListData() {
        guard let repo = repository else { return }
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            repo.getListPdf{ result, error in
                if error != nil {
                }else{
                    guard let data = result else { return }
                    do {
                        let dataObject = try JSONDecoder().decode(DataPDF.self, from: data)
                        
                        if let data = dataObject.data{
                            self.dataItems.append(contentsOf: data)
                            self.error = nil
                            self.isLoading = false
                        }
                        
                        self.delegate?.reloadTable()
                    }catch{
                        print(error)
                        self.error = error
                        self.isLoading = false
                    }
                }
            }
        }
        
    }
}
