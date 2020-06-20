//
//  Foo.swift
//  MemoryWarnings
//

import Foundation

struct Foo {
    init() {
        NotificationCenter.default.addObserver(forName: .UIApplicationDidReceiveMemoryWarning, object: nil, queue: nil) { (notification) in
            print("\(#function) received notification - \(notification)")
        }
    }
}
