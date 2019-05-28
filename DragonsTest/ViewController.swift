//
//  ViewController.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 27/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let a = TextFileHelper.DragonListAsString() {
            print(a)
        }
        
        
        let url = "https://demo6649570.mockable.io/dragoslist"
        let jsonService = JSONService()
        jsonService.request(url) { (result: DragonResult<DragonsListResponse>) in
            switch(result) {
            case .success(let dragonsListResponse):
                print("success \(dragonsListResponse.success)")
                for dragonResponse in dragonsListResponse.dragons {
                    print(dragonResponse ?? "nil")
                }
            case .failure(let error):
                print("error \(error)")
            }

        }

    }
    
    


}

