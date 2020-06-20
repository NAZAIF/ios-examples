//
//  MemoryPressureMonitor.swift
//  MemoryWarnings
//
//  Created by jerin on 20/06/20.
//  Copyright © 2020 Nyisztor, Karoly. All rights reserved.
//

import Foundation

class MemoryPressureMonitor {
    static let shared = MemoryPressureMonitor()
    
    private let memoryDS = DispatchSource.makeMemoryPressureSource(eventMask: [.warning, .critical])
    
    private init() {
        memoryDS.setEventHandler { [weak self] in
            if let event = self?.memoryDS.data, self?.memoryDS.isCancelled == false {
                switch event {
                case .warning:
                    print("MemoryPressureMonitor: Low memory warning")
                case .critical:
                    print("MemoryPressureMonitor: Critical memory warning")
                default:
                    print("MemoryPressureMonitor: Unknown event")

                }
            }
        }
        memoryDS.activate()
    }
    
    deinit {
        memoryDS.cancel() 
    }
}
