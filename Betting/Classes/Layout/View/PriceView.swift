//
//  PriceView.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import SwiftUI

struct PriceView: View {
    private enum Const {
        static let titleTextPadding: CGFloat = 4
        static let titleFontSize: CGFloat = 10
        static let cornerRadius: CGFloat = 8
    }

    internal let color: Color
    internal let title: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Const.cornerRadius)
                .fill(color)
            VStack {
                HStack {
                    Rectangle()
                        .fill(Color.clear)
                    Rectangle()
                        .fill(color)
                }
                HStack {
                    Rectangle()
                        .fill(color)
                    Rectangle()
                        .fill(Color.clear)
                }
            }
            Text(title)
                .font(.system(size: Const.titleFontSize))
                .foregroundColor(Assets.secondaryText.color.toColor)
                .padding(
                    EdgeInsets(
                        top: Const.titleTextPadding,
                        leading: .zero,
                        bottom: .zero,
                        trailing: Const.titleTextPadding
                    )
                )
        }
    }
}

#if DEBUG
struct PriceViewPreviews: PreviewProvider {
    static var previews: some View {
        PriceView(color: .orange, title: "Apple")
            .previewLayout(.fixed(width: 100, height: 50))
    }
}
#endif
