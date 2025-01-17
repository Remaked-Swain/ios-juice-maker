//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

final class JuiceMakerViewController: UIViewController {
    private let juiceMaker = JuiceMaker()
    
    @IBOutlet private var fruitStockLabels: [UILabel]!
    
    private var inventory: [FruitName: Int]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadInventory()
        self.syncStockLabels()
    }

    @IBAction private func touchJuiceOrderButton(_ sender: UIButton) {
        guard let juice = sender as? JuiceNameIdentifiable else { return }
        
        do {
            try juiceMaker.makeJuice(juiceName: juice.juiceName)
            self.loadInventory()
            self.syncStockLabels()
            showAlertCompletionJuiceMaking(juice.juiceName)
        } catch let error {
            showAlertOutOfStock(error)
        }
    }
    
    @IBAction private func touchNavButton(_ sender: UIBarButtonItem) {
        pushAdjustStockViewController()
    }
}

// MARK: Delegate
extension JuiceMakerViewController: InventorySendDelegate {
    func sendInventory(inventory: [FruitName: Int]) {
        self.inventory = inventory
        syncStockLabels()
        juiceMaker.updateFruitStoreInventory(with: inventory)
    }
}

// MARK: Private Methods
extension JuiceMakerViewController {
    private func loadInventory() {
        self.inventory = juiceMaker.checkFruitStoreInventory()
    }
    
    private func syncStockLabels() {
        for fruitStockLabel in fruitStockLabels {
            guard let label = fruitStockLabel as? FruitStockIdentifiable,
                  let stock = inventory?[label.fruitType]
            else { return }
            
            fruitStockLabel.text = String(stock)
        }
    }
    
    private func showAlertCompletionJuiceMaking(_ juiceName: JuiceName) {
        let alert = UIAlertController(title: "\(juiceName.rawValue) 쥬스 나왔습니다! 맛있게 드세요!", message: nil, preferredStyle: .alert)
        let yes = UIAlertAction(title: "감사합니다!", style: .default)
        alert.addAction(yes)
        present(alert, animated: true, completion: nil)
    }
    
    private func showAlertOutOfStock(_ error: Error) {
        let alert = UIAlertController(title: "\(error)", message: nil, preferredStyle: .alert)
        let yes = UIAlertAction(title: "예", style: .default) { _ in
            self.pushAdjustStockViewController()
        }
        let no = UIAlertAction(title: "아니오", style: .destructive, handler: nil)
        alert.addAction(yes)
        alert.addAction(no)
        present(alert, animated: true, completion: nil)
    }
    
    private func pushAdjustStockViewController() {
        guard let adjustStockViewController = self.storyboard?.instantiateViewController(withIdentifier: "AdjustStockViewController") as? AdjustStockViewController
        else { return }
        
        adjustStockViewController.inventory = self.inventory
        adjustStockViewController.delegate = self
        self.navigationController?.pushViewController(adjustStockViewController, animated: true)
    }
}
