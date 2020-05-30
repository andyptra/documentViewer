//
//  ThumbnailsViewController.swift
//  privyTest
//
//  Created by andyptra on 5/29/20.
//  Copyright © 2020 andyptra. All rights reserved.
//

import UIKit
import PDFKit

protocol ThumbnailsViewControllerDelegate: class{
    func thumbnailsViewController(_ thumbnailGridViewController: ThumbnailsViewController, didSelectPage page: PDFPage)
}
class ThumbnailsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    open var pdfDocument: PDFDocument?
    weak var delegate: ThumbnailsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // Mark : function to setup CollectionView
    func setupCollectionView(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(closeBtnClick))
        
        // Register cell classes
        self.collectionView.register(ThumbnailCollectionViewCell.nib(), forCellWithReuseIdentifier: "cell")
        
        
        self.collectionView.backgroundColor = UIColor.gray
    }
    
    //MARK : action close button
    @objc func closeBtnClick(sender: UIBarButtonItem) {
        dismiss(animated: false, completion: nil)
    }
    
}

extension ThumbnailsViewController{
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pdfDocument?.pageCount ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ThumbnailCollectionViewCell
        if let page = pdfDocument?.page(at: indexPath.item) {
            let thumbnail = page.thumbnail(of: cell.bounds.size, for: PDFDisplayBox.cropBox)
            cell.imageThumb = thumbnail
            
            cell.pages.text = page.label
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let page = pdfDocument?.page(at: indexPath.item) {
            dismiss(animated: false, completion: nil)
            delegate?.thumbnailsViewController(self, didSelectPage: page)
        }
    }
}
