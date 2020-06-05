//
//  ViewController.swift
//  MNews
//
//  Created by admin on 28.05.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit
import Alamofire
//////////////////

class NewsViewController: UITableViewController {
  
  let itemsPerBatch = 15
  var currentRow : Int = 1
  var itemArray : [Article] = []
  
  let newsURL = "https://newsapi.org/v2/top-headlines"
  //var news: Empty?
  var myRefreshControl: UIRefreshControl {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    return refreshControl
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.prefetchDataSource = self
    tableView.rowHeight = 80
    tableView.refreshControl = myRefreshControl
    fetchRequest(numberPage: currentRow)
    
  }
  
  @objc private func refresh(sender: UIRefreshControl){
    fetchRequest(numberPage: currentRow)
    sender.endRefreshing()
  }
  
  @objc func fetchRequest(numberPage: Int){
    let parameters : [String : String] = [
      "apiKey" : "9413c8dcf5d548ea9a83965aeb4141f9",
      "country" : "ru",
      "pageSize" : "\(numberPage)"
      
    ]
    
//    let headers: HTTPHeaders = ["X-Api-Key" : "9413c8dcf5d548ea9a83965aeb4141f9"]
    
    Alamofire.request(newsURL, method: .get, parameters: parameters).response { (response) in
      //print(response)
      guard let data = response.data else { return }
      print(data)
      
      let decoder = JSONDecoder()
      do {
        let result = try decoder.decode(Empty.self, from: data)
        self.itemArray = result.articles
        //print(result)
        
        self.tableView.reloadData()
      
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}

extension NewsViewController: UITableViewDataSourcePrefetching {
  
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    fetchRequest(numberPage: 1)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)
    
    cell.textLabel?.text = itemArray[indexPath.row].title
  
    return cell
  }
  
  
}
  
  

