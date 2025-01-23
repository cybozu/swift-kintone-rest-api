//
//  View+Extension.swift
//  Example
//
//  Created by ky0me22 on 2024/12/18.
//

import SwiftUI

extension View {
    func cornerRadiusBorder() -> some View {
        self.padding(4)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray)
            }
            .padding(1)
    }

    func variadic(@ViewBuilder childrenHandler: @escaping (_VariadicView_Children) -> some View) -> some View {
        _VariadicView.Tree(MultiRoot(childrenHandler: childrenHandler)) {
            self
        }
    }

    func tag<Value: Hashable>() -> Value? {
        guard let _traits = Mirror(reflecting: self).descendant("traits", "storage"),
              let traits = _traits as? (any BidirectionalCollection) else {
            return nil
        }
        for element in traits {
            guard let _value = Mirror(reflecting: element).descendant("value", "tagged"),
                  let value = _value as? Value else {
                continue
            }
            return value
        }
        return nil
    }
}

private struct MultiRoot<Result: View>: _VariadicView_MultiViewRoot {
    var childrenHandler: (_VariadicView_Children) -> Result

    func body(children: _VariadicView.Children) -> some View {
        childrenHandler(children)
    }
}
