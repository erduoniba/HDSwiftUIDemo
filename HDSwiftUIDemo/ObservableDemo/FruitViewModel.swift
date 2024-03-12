//
//  FruitViewModel.swift
//  HDSwiftUIDemo
//
//  Created by denglibing on 2024/2/20.
//

import Foundation
import SwiftUI

/*
 MARK1：
 如何使用 objectWillChange 手动发送状态更新？
 https://wangchujiang.com/swiftui-example/advanced-state/demo5/index.html
 */

// MARK1
class UserAuthentication: ObservableObject {
    var username = "Taylor" {
        willSet {
            if username == "xxx" {
                // 手动执行状态的刷新
                objectWillChange.send()
            }
        }
    }
    @Published var nickName: String = ""
}

struct FruitModel: Identifiable, Hashable {
    let id: String = UUID().uuidString
    let name: String
    let count: Int
}

class FruitViewModel: ObservableObject {
    @Published var fruits = [FruitModel]()
    @Published var isLoading = true
    
    init() {
        print("FruitViewModel init")
    }
    
    func delete(indexSet: IndexSet) {
        fruits.remove(atOffsets: indexSet)
    }
    
    func getFruits() {
        if fruits.count > 0 {
            return
        }
        isLoading = true
        fruits.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            let appleFruit = FruitModel(name: "Apples", count: 3)
            let orangeFruit = FruitModel(name: "Orange", count: 1)
            let watermelonFruit = FruitModel(name: "Watermelon", count: 1)
            let bananaFruit = FruitModel(name: "Banana", count: 19)
            
            self.fruits.append(appleFruit)
            self.fruits.append(orangeFruit)
            self.fruits.append(watermelonFruit)
            self.fruits.append(bananaFruit)
            
            self.isLoading = false
        })
    }
    
}
