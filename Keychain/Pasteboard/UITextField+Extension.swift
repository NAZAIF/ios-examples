//
//  UITextField+Extension.swift
//  Pasteboard
//
import Foundation
import UIKit

extension UITextField {
    override open func copy(_ sender: Any?) {
        AppDelegate.customPasteboard?.string = self.text
    }
    
    override open func cut(_ sender: Any?) {
        AppDelegate.customPasteboard?.string = self.text
        self.text = nil
    }
    
    override open func paste(_ sender: Any?) {
        if let text = AppDelegate.customPasteboard?.string {
            self.text = text
        }
    }
    
}












