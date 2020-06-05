//
//  main.swift
//  App Startup
//
//  Created by jerin on 04/06/20.
//  Copyright © 2020 jerin. All rights reserved.
//

import UIKit

UIApplicationMain(CommandLine.argc, UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc)), NSStringFromClass(CustomApplication.self), NSStringFromClass(AppDelegate.self)
)
