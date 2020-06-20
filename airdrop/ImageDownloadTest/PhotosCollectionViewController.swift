//
//  PhotosCollectionViewController.swift
//  ImageDownloadTest
//
import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    static fileprivate let reuseIdentifier = "PhotosCollectionViewCell"
    
    @IBOutlet weak var imageView: UIImageView!
}

class PhotosCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
    
    lazy var photoLinks: [URL] = {
        var result = [URL]()
        // generate some URLs from freepik
        let baseURLString = "http://699340.youcanlearnit.net/"
        for i in 1...50 {
            let imagePath = baseURLString + String(format: "image%03d.jpg", i)
            if let imageURL = URL(string: imagePath) {
                result.append(imageURL)
            }
        }
        return result
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let width = view.frame.width/2
        let height = view.frame.height/3
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photoLinks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.reuseIdentifier, for: indexPath) as! PhotosCollectionViewCell
        
        // Configure the cell        
        concurrentQueue.async {
            if let imageData = try? Data(contentsOf: self.photoLinks[indexPath.row]),
                let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    cell.imageView.image = image
                }
            }
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? PhotosCollectionViewCell, let image = selectedCell.imageView.image {
            let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            present(activityController, animated: true, completion: nil)
        }
    }
}
