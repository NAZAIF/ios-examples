//
//  ViewController.swift
//  TMDb
//
//  Created by Moideen Nazaif VM on 16/07/19.
//  Copyright © 2019 Moideen Nazaif VM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var posterImages: [UIImage] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        // Do any additional setup after loading the view.
        TMDbClient.getPopularMoviePosters(completion: handlePopularMovieResponse(popularMovies:error:))
    }
    
    func handlePopularMovieResponse(popularMovies: [PopularMovieResult], error: Error?) {
        let group = DispatchGroup()
        popularMovies.forEach { movie in
            DispatchQueue.global(qos: .background).async(group: group) {
                group.enter()
                guard let imageData = try? Data(contentsOf: TMDbClient.Endpoints.posterPath(movie.posterPath).url) else {
                    print("DataError")
                    return
                }
                
                guard let image = UIImage(data: imageData) else {
                    print("image error")
                    return
                }
                
                self.posterImages.append(image)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.collectionView.reloadData()
        }
    }
    
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(posterImages.count)
        return posterImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PopularMovieCollectionViewCell
        
        cell.imageView.image = posterImages[indexPath.row]
        return cell
        
    }
    
    
}

