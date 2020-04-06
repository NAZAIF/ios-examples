//
//  InitialViewController.swift
//  Dog Picz
//
//  Created by Moideen Nazaif VM on 25/06/19.
//  Copyright © 2019 Moideen Nazaif VM. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    var breeds = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DogAPI.requestAllBreeds(completionHandler: handleAllBreedsResponse(breedsArray:error:))
        
    }
    
    func handleAllBreedsResponse(breedsArray: [String], error: Error?) {
        breeds = breedsArray
        
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
    }
    
    func handleRandomImageResponse(imageData: DogImage?, error: Error?) {
        guard let imageURL = URL(string: imageData?.message ?? "") else { return }
        DogAPI.getImageFromNetwork(url: imageURL, completionHandler: handleImageFileResponse(image:error:))
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}

extension InitialViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        DogAPI.requestRandomImageFor(breed: breeds[row], completionHandler: handleRandomImageResponse(imageData:error:))
    }
    
}
