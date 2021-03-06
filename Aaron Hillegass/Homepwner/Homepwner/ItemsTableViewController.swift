//
//  ItemsTableViewController.swift
//  Homepwner
//
//  Created by 김예진 on 2017. 10. 26..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {
    
    // MARK: - Properties
    var itemStore : ItemStore!
    var imageStore : ImageStore!
    
    
    // MARK: - Actions
    @IBAction func addNewItem(_ sender: AnyObject) {
        let newItem = itemStore.createItem()
        
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = NSIndexPath(row: index, section: 0)
            
            tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowItem" {
            if let row = tableView.indexPathForSelectedRow?.row {
                
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
                detailViewController.imageStore = imageStore
            }
        }
    }
    /*
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        if isEditing {
            sender.setTitle("Edit", for: .normal)
            
            setEditing(false, animated: true)
        } else {
            sender.setTitle("Done", for: .normal)
            
            setEditing(true, animated: true)
        }
    }
    */
    
    // MARK: - View life cycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets     // contentInset is like a padding.
        tableView.scrollIndicatorInsets = insets
        */
 
        //tableView.rowHeight = 65
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDateSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (itemStore.allItems.count + 1)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        cell.updateLabels()
        
        if isEqualToAllItemsCount(row: indexPath.row) {
            cell.nameLabel.text = "No more items!"
            cell.serialNumberLabel.text = ""
            cell.valueLabel.text = ""
        } else {
            let item = itemStore.allItems[indexPath.row]
            //cell.textLabel?.text = item.name
            //cell.detailTextLabel?.text = "$\(item.valueInDollars)"
            
            cell.nameLabel.text = item.name
            cell.serialNumberLabel.text = item.serialNumber
            cell.valueLabel.text = "$\(item.valueInDollars)"
        
            /*
            // Bronze Task
            if item.valueInDollars < 50 {
                cell.backgroundColor = UIColor.green
            } else {
                cell.backgroundColor = UIColor.red
            }
            */
 
            // Change the font size.
            //cell.textLabel?.font = cell.textLabel?.font.withSize(20)
            //cell.detailTextLabel?.font = cell.detailTextLabel?.font.withSize(20)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isEqualToAllItemsCount(row: indexPath.row) {
            return 44
        } else {
            return 60
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if isEqualToAllItemsCount(row: indexPath.row) {
            return UITableViewCellEditingStyle.none
        }
        else {
            return UITableViewCellEditingStyle.delete
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)"
            let message = "Are you sure you want to delete this item?"
            
            let actionSheet = UIAlertController (
                title: title,
                message : message,
                preferredStyle: .actionSheet
            )
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            actionSheet.addAction(cancelAction)
            
            let deleteAction = UIAlertAction (
                title: "Remove",
                style: .destructive,
                handler: {
                    action -> Void in
                    self.itemStore.removeItem(item: item)
                    self.imageStore.deleteImageForKey(key: item.itemKey)
                    self.tableView.deleteRows(
                        at: [indexPath as IndexPath],
                        with: .automatic
                    )
            }
            )
            actionSheet.addAction(deleteAction)
            present(actionSheet, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return !isEqualToAllItemsCount(row: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if isEqualToAllItemsCount(row: proposedDestinationIndexPath.row) {
            return sourceIndexPath
        } else {
            return proposedDestinationIndexPath
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)  {
        itemStore.moveItemAtIndex(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"     // change the title 'Delete' to 'Remove'
    }
    
    // MARK: - Function
    func isEqualToAllItemsCount(row : Int) -> Bool {
        if row == itemStore.allItems.count {
            return true
        } else {
            return false
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "ShowItem" {
            if let row = tableView.indexPathForSelectedRow?.row {
                if isEqualToAllItemsCount(row: row) {
                    let alert = UIAlertController (
                        title: "Information",
                        message: "The last line doesn't have any details.",
                        preferredStyle: .alert
                    )
                    let okAction = UIAlertAction (
                        title: "OK",
                        style: UIAlertActionStyle.default
                    )
                    alert.addAction(okAction)
                    present(alert, animated: true, completion: nil)
                    return false
                }
            }
        }
        return true
    }
    
}
