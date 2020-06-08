//
//  Binding.swift
//  Master Detail
//
//  Created by jerin on 08/06/20.
//  Copyright © 2020 nazaif. All rights reserved.
//

import Foundation

class Observable<T> {
    var bind: (T) -> () = {_ in}
    
    var value: T {
        didSet {
            bind(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
}
