//
//  UIViewControllerExtension.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 28/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import Foundation
import UIKit

enum AlertTitle {
    case warning
    case error
    
    var title : String {
        switch self {
        case .warning:
            return "Aviso"
        case .error:
            return "Erro"
        }
    }
}

extension UIViewController {
    
    @discardableResult func activateConstraints(_ visualFormat: String, views: [String : Any], metrics: [String : Any]? = nil) -> [NSLayoutConstraint] {
        
        return NSLayoutConstraint.activate(visualFormat, views: views, metrics: metrics)
    }
    
    func presentAlertWith(title: AlertTitle, message: String, handler: ((UIAlertAction) -> Void)? = nil ) {
        let alert = UIAlertController(title: title.title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: handler))
        present(alert, animated: true, completion: nil)
    }
    
    func isRunningTests() -> Bool {
        let environment = ProcessInfo().environment
        return (environment["XCInjectBundleInto"] != nil);
    }
    
}
