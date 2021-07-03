//
//  Coffee.swift
//  CoffeeMachine
//
//  Created by Дмитрий Дуденин on 03.07.2021.
//

import Foundation

protocol Coffee {
    var cost: Int { get }
}

class CoffeeDrink: Coffee {
    let cost: Int = 50
}

protocol CoffeeDecorator: Coffee {
    var base: Coffee { get }
    init(base: Coffee)
}

class Milk: CoffeeDecorator {
    let base: Coffee
    
    required init(base: Coffee) {
        self.base = base
    }
    
    var cost: Int {
        return self.base.cost + 10
    }
}

class Whip: CoffeeDecorator {
    let base: Coffee
    
    required init(base: Coffee) {
        self.base = base
    }
    
    var cost: Int {
        return self.base.cost + 20
    }
}

enum SugarCount: Int {
    case none = 0
    case single = 1
    case double = 2
}

class Sugar: CoffeeDecorator {
    let base: Coffee
    let count: SugarCount
    
    required init(base: Coffee) {
        self.base = base
        self.count = .none
    }
    
    init(base: Coffee, sugar: SugarCount) {
        self.base = base
        self.count = sugar
    }
    
    var cost: Int {
        return self.base.cost + 5 * self.count.rawValue
    }
}
