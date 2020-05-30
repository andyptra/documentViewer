//
//  PdfViewController.swift
//  privyTest
//
//  Created by andyptra on 5/28/20.
//  Copyright © 2020 andyptra. All rights reserved.
//

import UIKit
import PDFKit

class PdfViewController: UIViewController {
    var pdfDOC: PDFDocument!
    var pdfxview: PDFView!
    var TitleHeader : String = ""
    let toolKitView = ToolKitView.instanceFromNib()
    weak var observe : NSObjectProtocol?
    var imageOne :CustomImageView = CustomImageView(imageIcon: UIImage(named: "logo-privy-colored"), location: CGPoint(x: 10, y: 330), size: CGRect(x: CGPoint(x: 30, y: 200).x, y: CGPoint(x: 30, y: 200).y, width: 250.0, height: 150.0))
    
    var imageTwo :CustomImageView = CustomImageView(imageIcon: UIImage(named: "swift"), location: CGPoint(x: 30, y: 200), size: CGRect(x: CGPoint(x: 30, y: 200).x, y: CGPoint(x: 30, y: 200).y, width: 150.0, height: 150.0))
    var isShowImage : Bool = false
    var urlString : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = TitleHeader
        
        // MARK : image Draggable
        imageOne.isHidden = true
        imageTwo.isHidden = true
        
        
        
        
        // MARK : PDF
        pdfxview = PDFView(frame: self.view.bounds)
        pdfxview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(pdfxview)
        pdfxview.autoScales = true
        pdfxview.addSubview(self.imageOne)
        pdfxview.addSubview(self.imageTwo)
        guard let url = URL(string: urlString) else {return}
        do{
            let data = try Data(contentsOf: url)
            pdfDOC = PDFDocument(data: data)
            pdfxview.document = pdfDOC
        }catch let err{
            print(err.localizedDescription)
        }
        
        // MARK : ToolKitView
        toolKitView.frame = CGRect(x: 10, y: view.frame.height - 60, width: self.view.frame.width - 20, height: 40)
        self.view.addSubview(toolKitView)
        toolKitView.bringSubviewToFront(self.view)
        toolKitView.thumbBtn.addTarget(self, action: #selector(thumbBtnClick), for: .touchUpInside)
        toolKitView.imageBtn.addTarget(self, action: #selector(imageBtnClick), for: .touchUpInside)
        toolKitView.editBtn.addTarget(self, action: #selector(searchBtnClick), for: .touchUpInside)
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        view.addGestureRecognizer(tapgesture)
    }
    
    // MARK : action tapGesture
    @objc func tapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: CATransaction.animationDuration()) { [weak self] in
            self?.toolKitView.alpha = 1 - (self?.toolKitView.alpha)!
        }
    }
    
    // MARK : action Button Image Click
    @objc func imageBtnClick(sender: UIButton) {
        if  isShowImage {
            isShowImage = false
            setupImage(status: true)
        }
        else {
            isShowImage = true
            setupImage(status: false)
        }
    }
    
    // MARK : action Button Thumbnails Click
    @objc func thumbBtnClick(sender: UIButton!) {
        setupImage(status: true)
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        
        let width = (view.frame.width - 10 * 4) / 3
        let height = width * 1.5
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let thumbnailViewController = ThumbnailsViewController(collectionViewLayout: layout)
        thumbnailViewController.pdfDocument = pdfDOC
        thumbnailViewController.delegate = self
        thumbnailViewController.TitleHeader = TitleHeader
        let nav = UINavigationController(rootViewController: thumbnailViewController)
        self.present(nav, animated: true, completion:nil)
    }
    
    // MARK : action Search PDF
    @objc func searchBtnClick(sender: UIButton) {
        setupImage(status: true)
        let searchViewController = SearchTableViewController()
        searchViewController.pdfDocument = pdfDOC
        searchViewController.delegate = self
        
        let nav = UINavigationController(rootViewController: searchViewController)
        self.present(nav, animated: false, completion:nil)
    }
    
    
    // MARK : setup image show or hide
    func setupImage(status : Bool) {
        self.imageOne.isHidden = status
        self.imageTwo.isHidden = status
    }
}

// MARK : extension for searchtabledelegate
extension PdfViewController: SearchTableViewControllerDelegate {
    func searchTableViewController(_ searchTableViewController: SearchTableViewController, didSelectSerchResult selection: PDFSelection) {
        selection.color = UIColor.yellow
        pdfxview.currentSelection = selection
        pdfxview.go(to: selection)
    }
}

//MARK : extension for thumbnail delagate
extension PdfViewController: ThumbnailsViewControllerDelegate {
    
    func thumbnailsViewController(_ thumbnailGridViewController: ThumbnailsViewController, didSelectPage page: PDFPage) {
        self.pdfxview.go(to: page)
    }
}
