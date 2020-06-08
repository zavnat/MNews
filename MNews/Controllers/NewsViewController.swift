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
  
  var fetchingMore = false
  var currentPage = 1
  var items : [Article] = []
  
  let newsURL = "https://newsapi.org/v2/everything"
  var myRefreshControl: UIRefreshControl {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    return refreshControl
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = 80
    let loadingNib = UINib(nibName: "LoadingCell", bundle: nil)
    tableView.register(loadingNib, forCellReuseIdentifier: "loadingCell")
    tableView.refreshControl = myRefreshControl
    fetchRequest()
    
  }
  
  @objc private func refresh(sender: UIRefreshControl){
    currentPage = 1
    items = []
    tableView.reloadData()
    fetchRequest()
    sender.endRefreshing()
  }
  
  @objc func fetchRequest(){
    
    fetchingMore = true
    if currentPage > 1 {
       tableView.reloadSections(IndexSet(integer: 1), with: .none)
    }
    
    let parameters : [String : String] = [
      "apiKey" : "9413c8dcf5d548ea9a83965aeb4141f9",
      "q" : "*",
      "pageSize" : "30",
      "page" : "\(currentPage)"
      
    ]
 
    Alamofire.request(newsURL, method: .get, parameters: parameters).response { (response) in
      //print(response)
      guard let data = response.data else { return }
      let decoder = JSONDecoder()
      do {
        let result = try decoder.decode(Empty.self, from: data)
        self.items += result.articles
        self.currentPage += 1
        self.fetchingMore = false
        
        self.tableView.reloadData()
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}

extension NewsViewController {
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return items.count
    } else if section == 1 && fetchingMore {
      return 1
    }
    return 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)
      cell.textLabel?.text = items[indexPath.row].title
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as! LoadingCell
      cell.spinner.startAnimating()
      return cell
    }
    
  }
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    if offsetY > contentHeight - scrollView.frame.height * 2 {
      if !fetchingMore && currentPage < 4 {
        fetchRequest()
      }
    }
  }
  
}
  
  

