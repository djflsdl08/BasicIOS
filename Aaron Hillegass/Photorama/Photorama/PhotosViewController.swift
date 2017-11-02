//
//  PhotosViewController.swift
//  Photorama
//
//  Created by 김예진 on 2017. 10. 31..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {
    
    // MARK: - Properties
    //@IBOutlet var imageView: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        store.fetchInterestingPhotos() {
            (PhotosResult) -> Void in
            
            /*
            switch PhotosResult {
            case let .Success(photos):
                print("Successfully found \(photos.count) photos.")
                
                if let firstPhoto = photos.first {
                    self.store.fetchImage(for: firstPhoto) {
                        (imageResult) -> Void in
                        
                        switch imageResult {
                        case let .Success(image):
                            self.imageView.image = image
                        case let .Failure(error):
                            print("Error downloading image: \(error)")
                        }
                    }
                }
            case let .Failure(error):
                print("Error fetching recent photos: \(error))")
            }
            */
            
            OperationQueue.main.addOperation {
                switch PhotosResult {
                case let .Success(photos):
                    print("Successfully founc \(photos.count) photos.")
                    self.photoDataSource.photos = photos
                case let .Failure(error):
                    self.photoDataSource.photos.removeAll()
                    print("Error fetching photos: \(error)")
                }
                self.collectionView.reloadSections(IndexSet(integer:0))
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        
        store.fetchImage(for: photo) {
            (result) -> Void in
            
            OperationQueue.main.addOperation {
                let photoIndex = self.photoDataSource.photos.index(of: photo)!
                let photoIndexPath = IndexPath(row: photoIndex, section: 0)
                if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                    cell.updateWithImage(image: photo.image)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPhoto" {
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
                let photo = photoDataSource.photos[selectedIndexPath.row]
                
                let destinationVC = segue.destination as! PhotoInfoViewController
                destinationVC.photo = photo
                destinationVC.store = store
            }
        }
    }
}
