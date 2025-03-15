//
//  RoundedCornerShape.swift
//  EstihlaalVV2
//
//  Created by Aliah Alhameed on 13/09/1446 AH.
//

import SwiftUI

struct RoundedCornerShape2: Shape {
    var corners: UIRectCorner
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
