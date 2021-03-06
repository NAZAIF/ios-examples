//
//  ViewModel.swift
//  Master Detail
//
//  Created by jerin on 08/06/20.
//  Copyright © 2020 nazaif. All rights reserved.
//

import Foundation


class ViewModel {
    private var myModel = Model<Observable<Date>>()
    
    func addEntry() {
        let dateObservable = Observable(Date())
        myModel.insert(dateObservable)
        dateObservable.bind = {_ in
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "updateUI")))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            dateObservable.value = Date()
        }
    }
    
    var count: Int {
        return myModel.count
    }
    
    func removeEntry(at index: Int) {
        myModel.remove(at: index)
    }
    
    subscript(index: Int) -> String? {
        guard let date = myModel[index] else {
            return nil
        }
        return date.value.description
    }
}
