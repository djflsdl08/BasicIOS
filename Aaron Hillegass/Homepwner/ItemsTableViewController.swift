//
//  ItemsTableViewController.swift
//  Homepwner
//
//  Created by 김예진 on 2017. 10. 26..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {

    var itemStore : ItemStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets     // contentInset is like a padding.
        tableView.scrollIndicatorInsets = insets
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)

        let item = itemStore.allItems[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        return cell
    }
    
}