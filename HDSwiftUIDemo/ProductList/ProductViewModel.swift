//
//  ProductViewModel.swift
//  HDSwiftUIDemo
//
//  Created by denglibing on 2024/3/12.
//

import Foundation
import SwiftUI

struct ProductModel: Decodable {
    struct GoodShop: Decodable {
        let goodShopName: String
    }
    
    var wareId: String
    let wname: String
    let imageurl: String
    let jdPrice: String
    let reviews: String
    let goodShop: GoodShop
    
    let toShopUrl: String
}

class ProductViewModel: ObservableObject {
    @Published var productList: [ProductModel] = []
    
    func requestProductList(refresh: Bool) {
        guard let path = Bundle.main.url(forResource: "ProductList", withExtension: "json") else { return }
        guard let data = try? Data(contentsOf: path) else { return }
        
        let decode = JSONDecoder()
        if let list = try? decode.decode([ProductModel].self, from: data) {
            if refresh {
                productList = list
            }
            else {
                productList.append(contentsOf: list)
            }
        }

    }
}
