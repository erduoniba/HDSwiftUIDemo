//
//  ProductViewModel.swift
//  HDSwiftUIDemo
//
//  Created by denglibing on 2024/3/12.
//

import Foundation
import SwiftUI

struct ProductModel: Decodable, Identifiable {
    // 假设这是一个唯一的标识符
    var id: String?
    
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
    
    @Published var isLoadingMore = false
    @Published var hasMore = true
    
    func requestProductList(refresh: Bool) {
        guard !isLoadingMore else { return }
        
        debugPrint("requestProductList: \(refresh)")
        
        guard let path = Bundle.main.url(forResource: "ProductList", withExtension: "json") else { return }
        guard let data = try? Data(contentsOf: path) else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoadingMore = true
            
            let decode = JSONDecoder()
            if var list = try? decode.decode([ProductModel].self, from: data) {
                if refresh {
                    self.productList.removeAll()
                    // 设置每个产品的 id,
                    for index in list.indices {
                        list[index].id = UUID().uuidString
                    }
                    self.productList = list
                    self.hasMore = true
                }
                else {
                    if self.hasMore {
                        // 设置每个产品的 id，解决加载更多是数据的时候，前面数据还是会刷新的问题
                        for index in list.indices {
                            list[index].id = UUID().uuidString
                        }
                        self.productList.append(contentsOf: list)
                    }
                }
                
                if self.productList.count > 100 {
                    self.hasMore = false
                    self.isLoadingMore = true
                }
                else {
                    self.hasMore = true
                    self.isLoadingMore = false
                }
            }
        }
    }
}
