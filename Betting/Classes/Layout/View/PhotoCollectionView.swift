//
//  PhotoCollectionView.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import SwiftUI

private enum Env {
    static let columnCount = 3
    static let vSpacing: CGFloat = 8
    static let hSpacing: CGFloat = 8
    static let topSpaceHeight: CGFloat = 80
    static let bottomSpaceHeight: CGFloat = 100
}

struct PhotoCollectionView: View {
    @Binding internal var data: [PhotoList.Photo]
    internal let geometry: GeometryProxy

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: Env.vSpacing) {
                Spacer()
                    .frame(width: geometry.size.width, height: Env.topSpaceHeight)
                Rows(data: $data, geometry: geometry)
                    .frame(width: geometry.size.width)
                Spacer()
                    .frame(width: geometry.size.width, height: Env.bottomSpaceHeight)
            }
        }
    }
}

private struct Rows: View {
    @Binding internal var data: [PhotoList.Photo]
    internal let geometry: GeometryProxy

    var body: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: Env.vSpacing) {
            ForEach((0..<data.count).map { GridIndex(id: $0) }) { row in
                ZStack {
                    PhotoViewCell(
                        url: URL(string: loadData(row: row.id)?.url ?? ""),
                        title: loadData(row: row.id)?.title ?? ""
                    )
                    CellButtonView(data: loadData(row: row.id)!) // FIXME: optional
                }
                    .frame(width: cellSize, height: cellSize)
            }
        }
    }

    private var columns: [GridItem] {
        Array(repeating: .init(.fixed(cellSize)), count: Env.columnCount)
    }

    private var cellSize: CGFloat {
        (geometry.size.width - Env.hSpacing * CGFloat((Env.columnCount + 1))) / CGFloat(Env.columnCount)
    }

    private func loadData(row: Int) -> PhotoList.Photo? {
        data[safe: row]
    }
}

// swiftlint:disable identifier_name
private struct GridIndex: Identifiable {
    var id: Int
}
// swiftlint:enable identifier_name

#if DEBUG
struct PhotoCollectionViewPreviews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            PhotoCollectionView(data: .constant(self.photos), geometry: geometry)
        }
    }

    // swiftlint:disable force_try
    static var photos: [PhotoList.Photo] {
        let path = Bundle.main.path(forResource: "PhotoListResponse", ofType: "json")!
        let data = FileHandle(forReadingAtPath: path)!.readDataToEndOfFile()
        let interestingness = try! JSONDecoder().decode(PhotoListResponse.self, from: data)
        return interestingness.convert().photos.photo
    }
    // swiftlint:enable force_try
}
#endif
