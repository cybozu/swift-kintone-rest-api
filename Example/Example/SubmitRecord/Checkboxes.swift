//
//  Checkboxes.swift
//  Example
//
//  Created by ky0me22 on 2024/12/19.
//

import SwiftUI

struct Checkboxes<Label, SelectionValue, Content>: View where Label: View, SelectionValue: Hashable, Content: View {
    var axis: Axis
    @Binding var selection: Set<SelectionValue>
    var content: () -> Content
    var label: () -> Label

    init(
        axis: Axis = .horizontal,
        selection: Binding<Set<SelectionValue>>,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.axis = axis
        _selection = selection
        self.content = content
        self.label = label
    }

    var body: some View {
        LabeledContent {
            switch axis {
            case .horizontal:
                HStack(alignment: .firstTextBaseline) {
                    mainBody
                }
            case .vertical:
                VStack(alignment: .leading) {
                    mainBody
                }
            }
        } label: {
            label()
        }
    }

    var mainBody: some View {
        ForEach(subviews: content()) { subview in
            let tag = subview.containerValues.tag(for: SelectionValue.self)
            Toggle(isOn: Binding<Bool>(
                get: {
                    if let tag {
                        selection.contains(tag)
                    } else {
                        false
                    }
                },
                set: { value in
                    guard let tag else { return }
                    if value {
                        selection.insert(tag)
                    } else {
                        selection.remove(tag)
                    }
                }
            )) {
                subview.lineLimit(1).truncationMode(.tail)
            }
            .toggleStyle(CheckboxToggleStyle())
        }
    }
}

private struct CheckboxToggleStyle: ToggleStyle {
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .foregroundStyle(isEnabled ? Color.accentColor : Color.secondary)
            configuration.label
                .foregroundStyle(isEnabled ? Color.primary : Color.secondary)
        }
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}
