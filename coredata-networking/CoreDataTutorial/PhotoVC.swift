//
//  ViewController.swift
//  CoreDataTutorial
//
//  Created by James Rochabrun on 3/1/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit
import CoreData

class PhotoVC: UITableViewController {
    
    private let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photos Feed"
        view.backgroundColor = .white
        tableView.register(PhotoCell.self, forCellReuseIdentifier: cellID)
        
        updateTableContent()
    }
    
    func showAlertWith(title: String, message: String, style: UIAlertControllerStyle = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "Dismiss" , style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    private func createPhotoEntityFrom(dictionary: [String:AnyObject]) -> NSManagedObject? {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        if let photoEntity = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: context) as? Photo {
            photoEntity.author = dictionary["author"] as? String
            photoEntity.tags = dictionary["tags"] as? String
            let mediaDict = dictionary["media"] as? [String: AnyObject]
            photoEntity.mediaUrl = mediaDict?["m"] as? String
            return photoEntity
        }
        return nil
    }
    
    private func saveInCoreDataWith(array: [[String:AnyObject]]) {
        _ = array.map{createPhotoEntityFrom(dictionary: $0)}
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func clearData() {
        do {
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{context.delete($0)}}
                CoreDataStack.sharedInstance.saveContext()
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }

    
    func updateTableContent() {
        do {
            try self.fetchedResultController.performFetch()
            print("COUNT FETCHED FIRST: \(self.fetchedResultController.sections![0].numberOfObjects)")
        } catch let error  {
            print("ERROR: \(error)")
        }
        let service = APIService()
        service.getDataWith { (result) in
            switch result {
            case .Success(let data):
                self.clearData()
                self.saveInCoreDataWith(array: data)
            case .Error(let message):
                DispatchQueue.main.async {
                    self.showAlertWith(title: "Error", message: message)
                }
            }
        }
    }
    
    lazy var fetchedResultController : NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Photo.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
         frc.delegate = self
        return frc
    }()
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PhotoCell
        if let photo = fetchedResultController.object(at: indexPath) as? Photo {
            cell.setPhotoCellWith(photo: photo)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetchedResultController.sections?.first?.numberOfObjects {
            return count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.width + 100 //100 = sum of labels height + height of divider line
    }
    
}

extension PhotoVC: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        default:
            break
        }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
}









