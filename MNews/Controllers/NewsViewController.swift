//
//  ViewController.swift
//  MNews
//
//  Created by admin on 28.05.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit
import CoreData
import Alamofire


class NewsViewController: UITableViewController {

  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  var dataToUI = [News]()
  
  var fetchingMore = false
  var currentPage = 1
  //var items = [Article]()
  
  let newsURL = "https://newsapi.org/v2/everything"
  var myRefreshControl: UIRefreshControl {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    return refreshControl
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

    
    tableView.rowHeight = 80
    let loadingNib = UINib(nibName: "LoadingCell", bundle: nil)
    tableView.register(loadingNib, forCellReuseIdentifier: "loadingCell")
    tableView.refreshControl = myRefreshControl
    
    load()
    fetchRequest()

  }
  
  @objc private func refresh(sender: UIRefreshControl){
    currentPage = 1
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
      //print(data)
      let decoder = JSONDecoder()
      do {
        let result = try decoder.decode(Empty.self, from: data)
        if result.articles.count > 0 && self.currentPage == 1 {
          self.deleteAllRecords()
        }
        var coreList = [News]()
        
        for article in result.articles{
          let news = News(context: self.context)

          news.title = article.title
          news.content = article.content

          news.origin = Origin(context: self.context)

          news.origin?.id = article.source.id
          news.origin?.name = article.source.name
          news.stringToURL = article.urlToImage

          coreList.append(news)
        }
        
        self.save()
        if self.currentPage == 1 {
          self.dataToUI = coreList
        } else {
          self.dataToUI.append(contentsOf: coreList)
        }
        
       
        self.currentPage += 1
        self.fetchingMore = false
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  func save (){
    do{
     try  context.save()
      print("Success save data to database")
      //tableView.reloadData()
    }catch{
      
    }
  }
  
  
  func deleteAllRecords() {
     
      let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
      let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

      do {
          try context.execute(deleteRequest)
          try context.save()
      } catch {
          print ("There was an error")
      }
  }
  
  func load (){
    let request: NSFetchRequest<News> = News.fetchRequest()
    do{
      dataToUI = try context.fetch(request)
      print("Success load data from database")
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }catch {

    }
  }
}

extension NewsViewController {
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return dataToUI.count
    } else if section == 1 && fetchingMore {
      return 1
    }
    return 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)
      cell.textLabel?.text = dataToUI[indexPath.row].title
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
  
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("You tapped cell number \(indexPath.row).")
    performSegue(withIdentifier: "goToDetail", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destinationVC = segue.destination as! DetailViewController
    
    if let indexPath = tableView.indexPathForSelectedRow {
      destinationVC.item = dataToUI[indexPath.row]
    }
    
  }
  
}
  
  

