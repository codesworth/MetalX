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
    
    @IBOutlet var metalView: MTKView!
    
    var device:MTLDevice!
    var commandQueue:MTLCommandQueue!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        metalView = MTKView(frame: UIScreen.main.bounds)
        self.view = metalView
        // Do any additional setup after loading the view.
        metalView.device = MTLCreateSystemDefaultDevice()
        device = metalView.device
        
        metalView.clearColor = Colors.ray
        metalView.delegate = self
        commandQueue = device.makeCommandQueue()
        
    }


}


extension ViewController:MTKViewDelegate{
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        //
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable, let descriptor = view.currentRenderPassDescriptor else {return}
        let c_buff = commandQueue.makeCommandBuffer()
        
        let c_encoder = c_buff?.makeRenderCommandEncoder(descriptor: descriptor)
        c_encoder?.endEncoding()
        c_buff?.present(drawable)
        c_buff?.commit()
    }
}
