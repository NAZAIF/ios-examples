//
//  CustomApplication.swift
//  App Startup
//
//  Created by jerin on 04/06/20.
//  Copyright © 2020 jerin. All rights reserved.
//

import UIKit

class CustomApplication: UIApplication {
    override func sendEvent(_ event: UIEvent) {
        print("Event: \(event)")
        super.sendEvent(event)
    }
}
