//
//  DetailViewController.swift
//  MNews
//
//  Created by admin on 08.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var header: UILabel!
  @IBOutlet weak var content: UITextView!
  @IBOutlet weak var imageView: UIImageView!
  var item: Article?
  
  override func viewDidLoad() {
        super.viewDidLoad()
    header.text = item?.title
    content.text = item?.content
    setImage(from: item!.urlToImage)
    }
    

  func setImage(from url: String) {
      guard let imageURL = URL(string: url) else { return }

      DispatchQueue.global().async {
          guard let imageData = try? Data(contentsOf: imageURL) else { return }

          let image = UIImage(data: imageData)
          DispatchQueue.main.async {
              self.imageView.image = image
          }
      }
  }
}
