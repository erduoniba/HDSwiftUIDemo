//
//  NavigationBarModifier.swift
//  HDSwiftUIDemo
//
//  Created by denglibing on 2024/3/13.
//

/*
 MARK1
 页面跳转和导航设置
 https://www.jianshu.com/p/dced1c3c9086
 */

import SwiftUI

struct NavigationBarModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode
    let title: String
    
    func body(content: Content) -> some View {
        content.navigationTitle(title)
            .navigationBarBackButtonHidden(true)
            // MARK1
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.gray)
            }))
    }
}

extension View {
    func hdNavigationBar(title: String) -> some View {
        self.modifier(NavigationBarModifier(title: title))
    }
}
