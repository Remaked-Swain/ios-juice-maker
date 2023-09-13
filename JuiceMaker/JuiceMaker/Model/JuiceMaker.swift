//
//  JuiceMaker - JuiceMaker.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

// 쥬스 메이커 타입
struct JuiceMaker {
    private let fruitStore: FruitStore = FruitStore()

    func makeJuice(juiceName: String) throws {
        try fruitStore.receiveOrder(juiceName: juiceName)
    }
    
    func checkFruitStoreInventory() -> [String: Int] {
        return fruitStore.checkInventoryStock()
    }
}
