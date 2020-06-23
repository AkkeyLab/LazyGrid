//
//  CellButtonView.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import SwiftUI

struct CellButtonView: View {
    @State private var tapAction: Bool = false
    let data: PhotoList.Photo

    var body: some View {
        Color.clear
            .contentShape(Rectangle())
            .onTapGesture {
                tapAction = true
            }
            .sheet(isPresented: $tapAction) {
                DetailView(imageURL: imageURL, title: data.title, photoId: data.id)
                    .edgesIgnoringSafeArea(.bottom)
            }
    }

    private var imageURL: URL? {
        URL(string: data.url ?? "")
    }
}

#if DEBUG
struct CellButtonViewPreviews: PreviewProvider {
    static var previews: some View {
        CellButtonView(data: photo)
    }

    // swiftlint:disable force_try
    static var photo: PhotoList.Photo {
        let path = Bundle.main.path(forResource: "PhotoListResponse", ofType: "json")!
        let data = FileHandle(forReadingAtPath: path)!.readDataToEndOfFile()
        let interestingness = try! JSONDecoder().decode(PhotoListResponse.self, from: data)
        return interestingness.convert().photos.photo.first!
    }
    // swiftlint:enable force_try
}
#endif
