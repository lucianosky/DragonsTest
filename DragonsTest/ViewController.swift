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
        
        let viewModel = DragonListViewModel()
        viewModel.getDragons { (result) in
            switch(result) {
            case .success(_):
                for dragon in viewModel.dragons {
                    print(dragon)
                }
            case .failure(let error):
                print("error \(error)")
            }
        }

    }
}
