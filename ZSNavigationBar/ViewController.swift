//
//  ViewController.swift
//  ZSNavigationBar
//
//  Created by iiiceblink on 2018/7/26.
//  Copyright © 2018年 Lingyue. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.setCustomBackgroundColor(UIColor.clear)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.scrollViewDidScroll(self.tableView)
    self.navigationController?.navigationBar.shadowImage = UIImage()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    self.navigationController?.navigationBar.reset()
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
    cell.textLabel?.text = "text"
    return cell
  }
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let color = UIColor(red: 0, green: 175 / 255.0, blue: 240 / 255.0, alpha: 1)
    let offsetY = scrollView.contentOffset.y
    
    if offsetY > 50 {
      let alpha = min(1, 1 - (50 + 64 - offsetY) / 64)
      self.navigationController?.navigationBar.setCustomBackgroundColor(color.withAlphaComponent(alpha))
    } else {
      self.navigationController?.navigationBar.setCustomBackgroundColor(color.withAlphaComponent(0))
    }
    
  }

}

