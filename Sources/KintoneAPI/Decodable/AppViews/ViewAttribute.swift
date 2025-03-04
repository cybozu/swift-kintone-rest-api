//
//  ViewAttribute.swift
//
//
//  Created by ky0me22 on 2025/03/04.
//

public enum ViewAttribute: Sendable, Equatable {
    case list(ListAttribute)
    case calendar(CalendarAttribute)
    case custom(CustomAttribute)
}
