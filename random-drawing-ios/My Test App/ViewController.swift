//
//  ViewController.swift
//  My Test App
//
//  Created by Moideen Nazaif VM on 08/01/20.
//  Copyright © 2020 Moideen Nazaif VM. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(UIColor.green.cgColor)
        context.setLineWidth(5)
        lines.forEach { line in
            for (i,p) in line.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        
        context.strokePath()
    }
    
    var lines = [[CGPoint]]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard var lastLine = lines.popLast() else { return }
        guard let point = touches.first?.location(in: nil) else { return }
        lastLine.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
}

class ViewController: UIViewController {
    
    let canvas = CanvasView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(canvas)
        canvas.backgroundColor = .white
        canvas.frame = view.frame
        
    }


}

