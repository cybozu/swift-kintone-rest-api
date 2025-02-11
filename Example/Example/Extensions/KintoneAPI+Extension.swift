//
//  KintoneAPI+Extension.swift
//  Example
//
//  Created by ky0me22 on 2025/01/21.
//

import KintoneAPI

extension KintoneApp: @retroactive Identifiable {
    public var id: Int { appID }
}

extension FieldProperty: @retroactive Identifiable {
    public var id: String { code }
}

extension FieldOption: @retroactive Identifiable {
    public var id: Int { index }
}

extension Entity.Read: @retroactive Identifiable {
    public var id: String { code }
}

extension RecordField.Read: @retroactive Identifiable {
    public var id: String { code }
}

extension File.Read: @retroactive Identifiable {
    public var id: String { fileKey }
}

extension RecordState: @retroactive Identifiable {
    public var id: String { name }
}

extension StatusAction: @retroactive Identifiable {
    public var id: String { name }
}
