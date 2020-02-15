//
//  ViewController.swift
//  MeasureWriteSpeed
//
//  Created by 张睿杰 on 2020/2/15.
//  Copyright © 2020 张睿杰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.url(forResource: "testspeed", withExtension: "text")
        let documentsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let data = try! Data(contentsOf: path!)
        let string = data.base64EncodedString()
        let rounds = [1, 10, 100, 1000, 10000, 100000]
        for round in rounds {
            var list: [String] = []
            for _ in 0..<round {
                list.append(string)
            }
            let data = try! JSONSerialization.data(withJSONObject: list, options: [])
            let start = CFAbsoluteTimeGetCurrent()
            let filePath = documentsPath.appendingPathComponent("test\(round)")
            try! data.write(to: filePath)
            let diff = CFAbsoluteTimeGetCurrent() - start
            var attr = try! FileManager.default.attributesOfItem(atPath: filePath.path) as! NSDictionary
            print("Took \(diff) seconds")
            print("File size is \(attr.fileSize())")
        }
    }
}

