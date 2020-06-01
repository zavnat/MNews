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
  
  let newsURL = "https://newsapi.org/v2/top-headlines"
  var news: Empty?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    fetchRequest()
  }
  
  func fetchRequest(){
    let parameters : [String : String] = [
      "apiKey" : "9413c8dcf5d548ea9a83965aeb4141f9",
      "country" : "ru",
      "pageSize" : "10"
      
    ]
    
//    let aaa = Alamofire.request(newsURL, method: .get, parameters: parameters)
//    print(aaa)
//    let headers: HTTPHeaders = ["X-Api-Key" : "9413c8dcf5d548ea9a83965aeb4141f9"]
    
    Alamofire.request(newsURL, method: .get, parameters: parameters).response { (response) in
      //print(response)
      guard let data = response.data else { return }
      print(data)
      
      let decoder = JSONDecoder()
      do {
        let result = try decoder.decode(Empty.self, from: data)
        self.news = result
        print(result)
//        print(result.articles[0])
        self.tableView.reloadData()
//        print(result.articles.count)
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}

extension NewsViewController {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return news?.articles.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)
    
    cell.textLabel?.text = news?.articles[indexPath.row].title
  
    return cell
  }
  
  
}
  
  

