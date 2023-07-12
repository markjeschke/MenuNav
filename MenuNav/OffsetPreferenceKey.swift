//
//  OffsetPreferenceKey.swift
//  MenuNav
//
//  Created by Mark Jeschke on 7/11/23.
//

import SwiftUI

// MARK: Offset Preference Key
struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: Offset View Extension
extension View {
    @ViewBuilder
    func offset(coordinateSpace: CoordinateSpace,
                completion: @escaping (CGFloat) -> ()) -> some View {
        self.overlay {
            GeometryReader { proxy in
                let minY = proxy.frame(in: coordinateSpace).minY
                Color.clear
                    .preference(key: OffsetKey.self, value: minY)
                    .onPreferenceChange(OffsetKey.self) { value in
                        completion(value)
                    }
            }
        }
    }
}
