//
//  Presenter.swift
//  Master Detail
//
//  Created by jerin on 08/06/20.
//  Copyright © 2020 nazaif. All rights reserved.
//

import Foundation

class Presenter {
    private var myModel = Model<Date>()
    
    func addEntry() {
        myModel.insert(Date())
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
        return date.description
    }
}
