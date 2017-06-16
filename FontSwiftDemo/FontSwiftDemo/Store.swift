//
//  Store.swift
//  FontSwiftDemo
//
//  Created by shenzhenshihua on 2017/6/16.
//  Copyright © 2017年 shenzhenshihua. All rights reserved.
//

import UIKit

class Store: NSObject {
    
    
    func returnPath(path:String) -> String {
        
        let mypath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
        return mypath + "/" + path
    }
    
    func read(path:String) -> Any {
        let mypath = self.returnPath(path: path)
        let anyStr =  NSKeyedUnarchiver.unarchiveObject(withFile:mypath)
    
        return anyStr ?? "No"
    }
    
    func write(any: Any, path: String) -> Bool {
        let mypath = self.returnPath(path: path)
        let isok = NSKeyedArchiver.archiveRootObject(any, toFile: mypath)
        return isok
    }

    
    
}
