//
//  DragonListViewController.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
}

private struct Consts {
    static let title = "Dracarys!"
}

class DragonListViewController: BaseViewController {
   
    var viewModel: DragonListViewModelProtocol
    
    init(viewModel: DragonListViewModelProtocol? = nil) {
        self.viewModel = viewModel ?? DragonListViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#file) \(#function) not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createSubviews()
        getDragons()
    }
    
    private func createSubviews() {
        title = Consts.title
    }

    private func getDragons() {
        viewModel.getDragons { (result) in
            switch(result) {
            case .success(_):
                for dragon in self.viewModel.dragons {
                    print(dragon)
                }
            case .failure(let error):
                print("error \(error)")
            }
        }
    }
    
}
