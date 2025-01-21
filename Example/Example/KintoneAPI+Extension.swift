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
    public var id: String { index }
}

extension FieldEntity: @retroactive Identifiable {
    public var id: String { code }
}
