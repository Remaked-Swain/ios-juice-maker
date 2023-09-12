//
//  JuiceMaker - FruitStore.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

// 과일 저장소 타입
final class FruitStore {
    // Fruits Properties
    private var fruitsStorage: [FruitType:Int] = [
        .strawberry : 10, .banana : 10, .kiwi : 10, .mango : 10, .pineapple : 10
    ]
    
//    , .banana : 10, .kiwi : 10, .pineapple : 10, .mango : 10
    
    // 주문 받은 것대로 재고 빼기
    func receiveOrder(juiceType: JuiceType) {
        let totalIng = makingJuice(juice: juiceType)
        let firtIng = totalIng.0
        let secondIng = totalIng.1
        checkQuantity(firstIngfredient: firtIng, secondIngredient: secondIng)
        
        
    }
}

// MARK: Nested Types
extension FruitStore {
    @frozen enum JuiceType {
        case strawberryJuice
        case strawberryBananaMixJuice
//        case bananaJuice, kiwiJuice, pineappleJuice, strawberryBananaMixJuice, mangoJuice, mangoKiwiMixJuice
    }
    
    @frozen enum FruitType {
        case strawberry, banana, kiwi, pineapple, mango
    }
    
    struct Fruit {
        let fruitType: FruitType
        let quantity: Int
    }
}

// MARK: Private methods
extension FruitStore {
    
    //레시피 함수 (주스메뉴를 받아서 필요한 재료를 말해주는 함수)
    private func makingJuice(juice: JuiceType) -> (Fruit, Fruit?) {
        switch juice {
        case .strawberryJuice: return (Fruit(fruitType: .strawberry, quantity: 16), nil)
        
        case .strawberryBananaMixJuice: return (Fruit(fruitType: .strawberry, quantity: 10),Fruit(fruitType: .banana, quantity: 1))
        }
    }
    
    //재고 관리 함수 과일 수량이 음료 제조 가능한지 알려주는 함수
    private func checkQuantity(firstIngfredient: Fruit, secondIngredient: Fruit?) {
        guard let ing = fruitsStorage[firstIngfredient.fruitType] else { return }
        if secondIngredient != nil {
            guard let ing2 = fruitsStorage[secondIngredient.fruitType] else { return }
        }
        
        if let fruit2 = fruitsStorage[secondIngredient?.fruitType]{
            let ing2 = fruit2.value
        }
           
        if let ing2 = fruitsStorage[secondIngredient?.fruitType] {
            
        }
        
        if ing - firstIngfredient.quantity > 0 && Ing2 - firstIngfredient.quantity > 0 {
            print("음료 제조 가능")
            updateInventory(Fruit(fruitType: <#T##FruitType#>, quantity: <#T##Int#>), <#T##secondIngredient: Fruit?##Fruit?#>)
        }else {
            print("음료 제조 불가능")
        }
    }
    
    private func updateInventory(_ firstIngfredient: Fruit, _ secondIngredient: Fruit?) {
        
    }
}
