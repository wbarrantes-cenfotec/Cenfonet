//
//  ViewController.swift
//  Cenfonet
//
//  Created by wbarrantes-cenfotec on 06/20/2021.
//  Copyright (c) 2021 wbarrantes-cenfotec. All rights reserved.
//

import UIKit
import Cenfonet

struct Feed: Codable {
    var feed: String
}

class ViewController: UIViewController {

    var client: Client?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        client = Client(session: URLSession.shared)
        
        /*client?.fetch(type: Feed.self,
                      stringUrl: "",
                      method: .post,
                      parameters: [:]) { result in
            
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

