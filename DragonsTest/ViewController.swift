//
//  ViewController.swift
//  DragonsTest
//
//  Created by Luciano Sclovsky on 27/05/19.
//  Copyright © 2019 Luciano Sclovsky. All rights reserved.
//

import UIKit

struct DragonsListResponse: Decodable {
    let success: Bool
    let dragons: [DragonResponse?]
}

struct DragonResponse: Decodable {
    let id: Int?
    let title: String?
    let description: String?
    let age: Int?
    let image: String?
    let greeting_type: String?
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://demo6649570.mockable.io/dragoslist")!
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            if let data = data {
                print("data \(data)")
                let decoder = JSONDecoder()
                do {
                    let dragonsListResponse = try decoder.decode(DragonsListResponse.self, from: data)
                    print("success \(dragonsListResponse.success)")
                    for dragonResponse in dragonsListResponse.dragons {
                        print(dragonResponse ?? "nil")
                    }
                } catch let error {
                    print("error \(error)")
                }
            }
            if let response = response {
                print("response \(response)")
                if let httpResponse = response as? HTTPURLResponse {
                    print("statusCode \(httpResponse.statusCode)")
                }
            }
            if let error = error {
                print("error \(error)")
            }
            
        }
        task.resume()
        
    }


}

