//
//  ViewController.swift
//  FontSwiftDemo
//
//  Created by shenzhenshihua on 2017/6/16.
//  Copyright © 2017年 shenzhenshihua. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gaspar: UIButton!
    @IBOutlet weak var mftongxin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.download(path: "cakkkk")
        // Do any additional setup after loading the view, typically from a nib.
    } 

    
    
    func download(path:String) {
    
        let store = Store()
        _ = store.write(any: "hello", path: "hehe")
        
        let somes = store.read(path: "hehe")
        
        print(somes)
//       print(store.returnPath(path: path))
        
        

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

