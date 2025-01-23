//
//  EntityView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/23.
//

import KintoneAPI
import SwiftUI

struct EntityView: View {
    var entity: Entity.Read
    
    var body: some View {
        HStack(alignment: .top) {
            Text("Value:")
            Divider()
            VStack(alignment: .leading, spacing: 4) {
                CornerRadiusText("Type: \(entity.type.rawValue)")
                CornerRadiusText("Code: \(entity.code)")
                CornerRadiusText("Name: \(String(optional: entity.name))")
            }
        }
        .cornerRadiusBorder()
    }
}
