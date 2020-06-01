//
//  ViewController.swift
//  MNews
//
//  Created by admin on 28.05.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit
import Alamofire


class NewsViewController: UITableViewController {

  let newsURL = "https://newsapi.org/v2/top-headlines?"
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    fetchRequest()
  }

  func fetchRequest(){
    let parameters : [String : String] = [
      "country" : "ru",
      "apiKey" : "9413c8dcf5d548ea9a83965aeb4141f9",
      "pageSize" : "15"
      
    ]
    
   
    Alamofire.request(newsURL, method: .get, parameters: parameters).response{ (response) in
    guard let data = response.data else { return }
      let decoder = JSONDecoder()
      do {
        let result = try decoder.decode(Empty.self, from: data)
        print(result)
      } catch {
        print(error.localizedDescription)
      }
    }
}
}
  
  

