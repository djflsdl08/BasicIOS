//
//  ItemStore.swift
//  Homepwner
//
//  Created by 김예진 on 2017. 10. 26..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class ItemStore {
    // MARK: - Properties
    var allItems = [Item]()
    
    let itemArchiveURL : NSURL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent("items.archive") as NSURL
    }()
    
    /* Don't need anymore because of 'Edit' and 'Add' buttons.
    init() {
        for _ in 0..<5 {
            let _ = createItem()
        }
    }
    */
 
    // MARK: - Function
    func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        let movedItem = allItems[fromIndex]
        
        allItems.remove(at: fromIndex)
        allItems.insert(movedItem, at: toIndex)
    }
    
}
