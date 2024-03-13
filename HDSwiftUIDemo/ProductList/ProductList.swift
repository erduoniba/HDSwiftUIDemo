//
//  ProductList.swift
//  HDSwiftUIDemo
//
//  Created by denglibing on 2024/3/12.
//

import SwiftUI

struct ProductListDemo: View {
    @StateObject var viewModel = ProductViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        List {
            ForEach(viewModel.productList) { product in
                ProductCell(product: product)
                    .listRowSeparator(.hidden)
                    .frame(height: 120)
            }
            
            if viewModel.isLoadingMore == false {
                HStack {
                    Spacer().frame(height: 10)
                    ProgressView()
                    Spacer().frame(height: 10)
                }
                .onAppear {
                    if viewModel.hasMore {
                        viewModel.requestProductList(refresh: false)
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: -10, bottom: 0, trailing: -10))
        .hdNavigationBar(title: "ProductListDemo")
        .listStyle(.plain)
        .onAppear {
            viewModel.requestProductList(refresh: true)
        }
        .refreshable {
            // 在这里执行下拉刷新时的数据加载逻辑
            viewModel.requestProductList(refresh: true)
        }
    }
}

#Preview {
    ProductListDemo()
}
