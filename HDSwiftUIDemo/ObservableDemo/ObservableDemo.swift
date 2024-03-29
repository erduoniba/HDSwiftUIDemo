//
//  ObservableDemo.swift
//  HDSwiftUIDemo
//
//  Created by denglibing on 2024/2/20.
//

import SwiftUI

struct ObservableDemo: View {
    
    init() {
        print("ObservableDemo init")
    }
    
    // @ObservedObject 不管存储，会随着 View 的创建被多次创建
//    @ObservedObject var fruitViewModel: FruitViewModel = FruitViewModel()
    
    // @StateObject 当前视图只创建一次
    @StateObject var fruitViewModel: FruitViewModel = FruitViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var user = UserAuthentication()
    
    var body: some View {
        
        List {
            
            ForEach(fruitViewModel.fruits) { fruit in
                
                NavigationLink(destination: ObservableDemo()) {
                    HStack {
                        Text("\(fruit.count)")
                            .font(.subheadline)
                        
                        Spacer()
                            .frame(width: 30)
                        
                        Text(fruit.name)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                }
                .frame(height: 46)
            }
            .onDelete(perform: { indexSet in
                fruitViewModel.delete(indexSet: indexSet)
            })
            
            VStack(alignment: .leading) {
                TextField("Enter your name", text: $user.username)
                Text("Your username is: \(user.username)")
            }
            .padding(20)
            
            VStack(alignment: .leading) {
                TextField("Enter your nickname", text: $user.nickName)
                Text("Your nickname is: \(user.nickName)")
            }
            .padding(20)
            
        }
        .hdNavigationBar(title: "ObservableDemo")
        .onAppear(perform: {
            fruitViewModel.getFruits()
        })
        

        
    }
}

#Preview {
    ObservableDemo()
}
