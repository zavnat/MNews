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
  var item: Article?
  
  override func viewDidLoad() {
        super.viewDidLoad()
    header.text = item?.title
    content.text = item?.content

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
