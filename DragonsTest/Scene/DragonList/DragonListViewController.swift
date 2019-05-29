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
    static let tableCellId = "dragonCell"
}

class DragonListViewController: BaseViewController {
   
    var viewModel: DragonListViewModelProtocol
    
    let tableView = UITableView(.white, 300, false)

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
        createConstraints()
        getDragons()
    }
    
    private func createSubviews() {
        title = Consts.title
        view.backgroundColor = .white
        tableView.register(DragonTableViewCell.self, forCellReuseIdentifier: Consts.tableCellId)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }

    private func createConstraints() {
        let dict: [String: Any] = [
            "tbl": tableView,
        ]
        activateConstraints("V:|[tbl]|", views: dict)
        activateConstraints("H:|[tbl]|", views: dict)
    }


    private func getDragons() {
        viewModel.getDragons { (result) in
            switch(result) {
            case .success(_):
                for dragon in self.viewModel.dragons {
                    print(dragon.description ?? "no name")
                }
            case .failure(let error):
                print("error \(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension DragonListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dragons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Consts.tableCellId, for: IndexPath(row: indexPath.row, section: 0)) as? DragonTableViewCell
            else { return UITableViewCell() }
        
        
        cell.dragonLabel.text = viewModel.dragonDescription(forDragonInRow: indexPath.row)
        cell.hearButton.onTouched { [weak self] in
            guard let self = self else { return }
            self.presentAlertWith(title: "Mighty Dragon Says!",
                                  message: self.viewModel.dragonSound(forDragonInRow: indexPath.row),
                                  okMessage: "Ok, I'm afraid!")
        }

        viewModel.getDragonImage(forDragonInRow: indexPath.row) { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async() {
                    cell.dragonImageView.image = UIImage(data: data)
                }
            case .failure(let error):
                print(error)
            }
        }
        
        return cell

    }
    
}
