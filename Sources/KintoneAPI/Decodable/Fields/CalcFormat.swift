//
//  CalcFormat.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public enum CalcFormat: String, Decodable, Sendable {
    case number = "NUMBER"
    case numberDigit = "NUMBER_DIGIT"
    case dateTime = "DATETIME"
    case date = "DATE"
    case time = "TIME"
    case hourMinute = "HOUR_MINUTE"
    case dayHourMinute = "DAY_HOUR_MINUTE"
}
