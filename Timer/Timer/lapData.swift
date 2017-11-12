//
//  lapData.swift
//  Timer
//
//  Created by 김예진 on 2017. 11. 12..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import Foundation

class lapData {
    var lapCount : Int = 0
    var lapTime : String = ""
    
    init(lapTime: String, lapCount: Int) {
        self.lapTime = lapTime
        self.lapCount = lapCount
    }
}
