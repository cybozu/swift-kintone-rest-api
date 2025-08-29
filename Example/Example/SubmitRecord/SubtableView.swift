//
//  SubtableView.swift
//  Example
//
//  Created by ky0me22 on 2025/08/29.
//

import KintoneAPI
import SwiftUI

struct SubtableView: View {
    var fields: [Field]
    @Binding var values: [[RecordField.Write]]

    var body: some View {
        VStack {
            ForEach(values.indices, id: \.self) { index in
                SubtableRowView(
                    fields: fields,
                    recordFields: $values[index],
                    removeDisabled: index == 0,
                    removeButtonTapped: {
                        values.remove(at: index)
                    }
                )
            }
            HStack {
                Spacer()
                Button {
                    let array = fields.compactMap { field -> RecordField.Write? in
                        guard let value = field.attribute.recordFieldValue else { return nil }
                        return RecordField.Write(code: field.code, value: value)
                    }
                    values.append(array)
                } label: {
                    Label {
                        Text("Add Row")
                    } icon: {
                        Image(systemName: "plus")
                    }
                    .labelStyle(.titleAndIcon)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
            }
        }
    }
}

private struct SubtableRowView: View {
    var fields: [Field]
    @Binding var recordFields: [RecordField.Write]
    var removeDisabled: Bool
    var removeButtonTapped: () -> Void

    var body: some View {
        HStack {
            ForEach(fields) { field in
                RecordInputFieldView(
                    field: field,
                    fieldValues: Binding<[String: RecordFieldValue.Write]>(
                        get: { Dictionary(uniqueKeysWithValues: zip(recordFields.map(\.code), recordFields.map(\.value))) },
                        set: { newValue in recordFields = newValue.map { RecordField.Write(code: $0, value: $1) } }
                    )
                )
            }
            Button {
                removeButtonTapped()
            } label: {
                Image(systemName: "minus")
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.circle)
            .disabled(removeDisabled)
        }
    }
}
