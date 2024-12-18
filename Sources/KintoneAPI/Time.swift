//
//  Time.swift
//
//
//  Created by ky0me22 on 2024/12/18.
//

public struct Time: Codable, Sendable, CustomStringConvertible, Equatable {
    public var hour: Int
    public var minute: Int

    public var description: String {
        String(format: "%02d:%02d", hour %% 24, minute %% 60)
    }

    public init(hour: Int, minute: Int) {
        self.hour = hour %% 24
        self.minute = minute %% 60
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        let array = rawValue.components(separatedBy: ":")
        guard array.count >= 2, let hour = Int(array[0]), let minute = Int(array[1]) else {
            throw DecodingError.typeMismatch(Time.self, .init(
                codingPath: decoder.codingPath,
                debugDescription: "Failed to decode Time"
            ))
        }
        self.hour = hour
        self.minute = minute
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(description)
    }
}

infix operator %%

func %% (lhs: Int, rhs: Int) -> Int {
    ((lhs % rhs) + rhs) % rhs
}
