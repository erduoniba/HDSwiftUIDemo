//
//  ProductCell.swift
//  HDSwiftUIDemo
//
//  Created by denglibing on 2024/3/12.
//

import SwiftUI


struct ConditionalPadding: ViewModifier {
    var product: ProductModel

    func body(content: Content) -> some View {
        if product.imageurl.isEmpty {
            content.padding(20)
        } else {
            content
        }
    }
}

struct ProductCell: View {
    var product: ProductModel
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.imageurl)) { image in
                image.image?.resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .modifier(ConditionalPadding(product: product))

            VStack(alignment: .leading) {
                Text(product.wname)
                    .font(.subheadline)
                    .lineLimit(2)
                    .bold()
                
                Spacer()
                
                let prices = product.jdPrice.components(separatedBy: ".")
                if prices.count > 1 {
                    Text("¥")
                        .font(.caption)
                        .foregroundStyle(.red)
                    +
                    Text("\(prices[0])")
                        .font(.title3)
                        .foregroundStyle(.red)
                    +
                    Text(".\(prices[1])")
                        .font(.caption)
                        .foregroundStyle(.red)
                }
                else {
                    Text("¥")
                        .font(.caption)
                        .foregroundStyle(.red)
                    +
                    Text("\(product.jdPrice)")
                        .font(.title)
                        .foregroundStyle(.red)
                }
                                
                HStack(spacing: 0) {
                    Text(product.reviews + "  ")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .lineLimit(1)
                    
                    Text(product.goodShop.goodShopName)
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text("  >")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .lineLimit(1)
                }
            }
        }
        .padding(0)
        .frame(height: 120)
    }
}

#Preview {
    ProductCell(product: ProductModel(wareId: "57674695137", wname: "羿丰（LIGHTING） 2d蝴蝶形灯管吸顶荧光灯三基色方四针节能灯 2D-21W（正白光）尺寸13.5cm", imageurl: "https://img20.360buyimg.com/mobilecms/s799x799_jfs/t1/193078/19/1951/68674/60963279Ed4a5e916/243da30916e71d90.jpg!q70.dpg.webp", jdPrice: "10.8", reviews: "已售5000+件", goodShop: ProductModel.GoodShop(goodShopName: "广汇邦宏灯饰照明专营店"), toShopUrl: "https://jdlite-shop.jd.com/?venderId=825999&_fd=jdw"))
}
