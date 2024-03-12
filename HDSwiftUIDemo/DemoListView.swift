//
//  ContentView.swift
//  HDSwiftUIDemo
//
//  Created by denglibing on 2024/2/20.
//

import SwiftUI

enum ViewType: String {
    case observable = "ObservableDemo"
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .observable:
            ObservableDemo()
        }
    }
}

struct DemoItem: Identifiable, Hashable {
    let name: ViewType
    let id = UUID().uuidString
}

struct LazyView<Content: View>: View {
    private let build: () -> Content
    
    var body: some View {
        build()
    }
    
    public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
}


struct DemoListView: View {
    
    @State private var demoList: [DemoItem] = [
        DemoItem(name: .observable),
        DemoItem(name: .observable),
        DemoItem(name: .observable)
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(demoList, id: \.self) { demo in
                    let view = LazyView(ViewType(rawValue: demo.name.rawValue)?.view())
                    NavigationLink(destination: view, label: {
                        Text(demo.name.rawValue).font(.subheadline)
                    })
                }
            }
            .navigationBarTitle("DemoListView", displayMode: .inline)
        }
        .navigationViewStyle(.stack)
    }
    
}

#Preview {
    DemoListView()
}
