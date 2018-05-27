//
//  AddRentalImagesViewController.swift
//  iNesti
//
//  Created by Chen, Zian on 5/21/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

class AddRentalImagesViewController: BaseViewController {

    var rentalImages = [(String, UIImage)]()
    var cellWidth: CGFloat = 0
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        cellWidth = (self.view.frame.width - 80) / 3.0

        // Do any additional setup after loading the view.
    }
    
    private func reload() {
        collectionView.reloadData()
        collectionViewHeight.constant = CGFloat((rentalImages.count + 2) / 3) * cellWidth
    }
    
}

extension AddRentalImagesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rentalImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RentalImageCell", for: indexPath) as! RentalImageCell
        cell.delegate = self
        cell.index = indexPath.item
        cell.imageView.image = rentalImages[indexPath.item].1
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}

extension AddRentalImagesViewController: RentalImageCellDelegate {
    
    func deleteImageTapped(index: Int) {
        rentalImages.remove(at: index)
        reload()
    }
    
}


extension AddRentalImagesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func askToOpenGallaryOrCamera(sender: UIButton) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let openGalary = UIAlertAction(title: "相簿", style: .default) { (action) in
            self.openImagePickerWith(source: .photoLibrary, isAllowEditing: true)
        }
        let openCamera = UIAlertAction(title: "相机", style: .default) { (action) in
            self.openImagePickerWith(source: .camera, isAllowEditing: true)
        }
        let cancelSelect = UIAlertAction(title: "取消", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        actionSheet.addAction(openCamera)
        actionSheet.addAction(openGalary)
        actionSheet.addAction(cancelSelect)
        
//        if UIDevice.current.userInterfaceIdiom == .pad { // iPad MUST setup to present alertViewController
//            actionSheet.popoverPresentationController?.sourceView = collectionViewMaskButton
//        }
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    /// MARK: - Image Picker delegate
    func openImagePickerWith(source: UIImagePickerControllerSourceType, isAllowEditing: Bool){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = source
        imagePicker.allowsEditing = isAllowEditing
        imagePicker.delegate = self
        imagePicker.navigationBar.isTranslucent = false
        imagePicker.navigationBar.barTintColor = UIColor.in_yellow // Background color
        imagePicker.navigationBar.tintColor = .black // Cancel button ~ any UITabBarButton items
        imagePicker.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.black] // Title color
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var getImg: UIImage? = nil
        if let editedImg = info[UIImagePickerControllerEditedImage] as? UIImage {
            getImg = editedImg
        }else if let originalImg = info[UIImagePickerControllerOriginalImage] as? UIImage {
            getImg = originalImg
        }
        
        if let getImage = getImg {
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone.current
            formatter.dateFormat = "yyyy_MM_dd_HHmmss"
            let dateTimeStr: String = formatter.string(from: Date())
            rentalImages.append((dateTimeStr, getImage))
            reload()
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

protocol RentalImageCellDelegate: class {
    func deleteImageTapped(index: Int)
}

class RentalImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    weak var delegate: RentalImageCellDelegate?
    var index = 0
    
    @IBAction func handleDeleteButton(sender: UIButton) {
        delegate?.deleteImageTapped(index: index)
    }
    
}
