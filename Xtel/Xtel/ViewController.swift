//
//  ViewController.swift
//  Xtel
//
//  Created by Shadrach Mensah on 16/03/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import UIKit
import MetalKit



class ViewController: UIViewController {
    
    enum Colors{
        static let ray = MTLClearColor(red: 0, green: 0.4, blue: 0.21, alpha: 1)
    }
    
    var metalView:MTKView{
        return view as! MTKView
    }

    var device:MTLDevice!
    var commandQueue:MTLCommandQueue!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        metalView.device = MTLCreateSystemDefaultDevice()
        device = metalView.device
        
        metalView.clearColor = Colors.ray
        
        commandQueue = device.makeCommandQueue()
        let c_buff = commandQueue.makeCommandBuffer()
        
        let c_encoder = c_buff?.makeRenderCommandEncoder(descriptor: metalView.currentRenderPassDescriptor!)
        c_encoder?.endEncoding()
        c_buff?.present(metalView.currentDrawable!)
        c_buff?.commit()
    }


}

