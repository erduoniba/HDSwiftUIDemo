//
//  SystemFontSizeView.swift
//  HDSwiftUIDemo
//
//  Created by denglibing on 2024/3/13.
//

import SwiftUI

/*
 官方系统字体大小参考：
 https://developer.apple.com/design/human-interface-guidelines/typography
 */

struct SystemFontSizeView: View {
    var body: some View {
        List {
            ForEach(Font.TextStyle.allCases, id: \.self) { textStyle in
                VStack(alignment: .leading) {
                    Text(textStyle.description)
                        .font(.system(textStyle))
                        .padding(EdgeInsets(top: 0, leading: -10, bottom: 0, trailing: -10))
                }
            }
        }
        .hdNavigationBar(title: "SystemFontSizeView")
    }
}

extension Font.TextStyle: CustomStringConvertible {
    public static var allCases: [Font.TextStyle] {
        [
            .largeTitle,
            .title,
            .title2,
            .title3,
            .headline,
            .subheadline,
            .body,
            .callout,
            .footnote,
            .caption,
            .caption2
        ]
    }
    
    public var description: String {
        switch self {
        case .largeTitle: return "Large Title（大标题 34）"
        case .title: return "Title（1级标题 28）"
        case .title2: return "Title 2（2级标题 22）"
        case .title3: return "Title 3（3级标题 20）"
        case .headline: return "Headline（标题文本 17bold）"
        case .subheadline: return "Subheadline（副标题文本 15）"
        case .body: return "Body（文本样式 17）"
        case .callout: return "Callout（注解文本 16）"
        case .footnote: return "Footnote（脚注文本 13）"
        case .caption: return "Caption（1级说明文字 12）"
        case .caption2: return "Caption 2（2级说明文字 11）"
        default: return "\(self)"
        }
    }
}

#Preview {
    SystemFontSizeView()
}
