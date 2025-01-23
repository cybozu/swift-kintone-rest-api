//
//  ArrayValueView.swift
//  Example
//
//  Created by ky0me22 on 2025/01/23.
//

import SwiftUI

struct ArrayValueView<Data, ID, Content>: View where Data : RandomAccessCollection, ID : Hashable, Content : View {
    var data: Data
    var content: (Data.Element) -> Content
    var id: KeyPath<Data.Element, ID>
    
    init(_ data: Data, id: KeyPath<Data.Element, ID>, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.id = id
        self.content = content
    }
    
    var body: some View {
        if data.isEmpty {
            CornerRadiusText("Array: empty")
        } else {
            HStack(alignment: .top) {
                Text("Array:")
                Divider()
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(data, id: id) { element in
                        content(element)
                    }
                }
            }
            .cornerRadiusBorder()
        }
    }
}

extension ArrayValueView where ID == Data.Element.ID, Data.Element : Identifiable {
    init(_ data: Data, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.id = \(Data.Element).id
        self.content = content
    }
}


