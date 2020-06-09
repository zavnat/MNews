//
//  DetailViewController.swift
//  MNews
//
//  Created by admin on 08.06.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit
import SDWebImage

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
    

  func setImage(from url: URL) {
    self.imageView.sd_setImage(with: url)
  }
}
