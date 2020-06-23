//
//  TopSpaceView.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import SwiftUI

struct TopSpaceView: View {
    private enum Const {
        static let loginButtonHeight: CGFloat = 50
        static let shadowRadius: CGFloat = 8
    }

    internal let width: CGFloat
    internal let height: CGFloat
    internal let color: Color
    internal let text: String
    internal var action: () -> Void

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottom)
                .frame(width: width, height: height)
            Button(
                action: {
                    action()
                },
                label: {
                    Text(text)
                        .font(.body)
                        .foregroundColor(Color.white)
                        .contentShape(Rectangle())
                        .frame(width: (width / 3) * 2, height: Const.loginButtonHeight)
                        .background(color)
                }
            )
            .cornerRadius(Const.loginButtonHeight / 2)
            .shadow(color: Assets.background.color.toColor, radius: Const.shadowRadius)
        }
        .frame(height: height)
    }

    private var gradientColors: [Color] {
        [
            Assets.background.color.toColor,
            Assets.clear.color.toColor
        ]
    }
}

#if DEBUG
struct TopSpaceViewPreviews: PreviewProvider {
    static var previews: some View {
        TopSpaceView(width: 320, height: 80, color: .pink, text: L10n.Button.SignIn.title) {}
            .background(Color.black)
            .previewLayout(.fixed(width: 320, height: 80))
    }
}
#endif
