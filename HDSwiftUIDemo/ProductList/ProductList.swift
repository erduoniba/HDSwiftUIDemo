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
            ForEach(viewModel.productList, id: \.wareId) { product in
                ProductCell(product: product)
                    .listRowSeparator(.hidden)
                    .frame(height: 120)
            }
        }
        .padding(EdgeInsets(top: 0, leading: -10, bottom: 0, trailing: -10))
        .hdNavigationBar(title: "ProductListDemo")
        .listStyle(.plain)
        .onAppear {
            viewModel.requestProductList(refresh: true)
        }
    }
}

#Preview {
    ProductListDemo()
}
