//
//  ViewController.swift
//  CoffeeMachine
//
//  Created by Дмитрий Дуденин on 03.07.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private var coffee: Observable<Coffee> = Observable(CoffeeDrink())
    
    @IBOutlet weak var milkControl: UISegmentedControl!
    @IBOutlet weak var whipControl: UISegmentedControl!
    @IBOutlet weak var sugarControl: UISegmentedControl!
    @IBOutlet weak var totalCostLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.coffee.addObserver(self, options: [.initial, .new], closure: { [weak self] value, _ in
            self?.totalCostLabel.text = "К оплате: \(value.cost) ₽"
        })
    }
    
    private func makeNewCoffee() {
        self.coffee.value = CoffeeDrink()
        
        if self.milkControl.selectedSegmentIndex == 1 {
            self.coffee.value = Milk(base: self.coffee.value)
        }
        
        if self.whipControl.selectedSegmentIndex == 1 {
            self.coffee.value = Whip(base: self.coffee.value)
        }
        
        let index = self.sugarControl.selectedSegmentIndex
        if  index != 0 {
            self.coffee.value = Sugar(
                base: self.coffee.value,
                sugar: SugarCount(rawValue: index) ?? .none
            )
        }
    }
    
    @IBAction func changingIngredients(_ sender: Any) {
        makeNewCoffee()
    }
    
    @IBAction func payButtonHandler(_ sender: Any) {
        self.coffee.value = CoffeeDrink()
        
        self.milkControl.selectedSegmentIndex = 0
        self.whipControl.selectedSegmentIndex = 0
        self.sugarControl.selectedSegmentIndex = 0
    }
}

