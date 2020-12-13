//
//  TextualError.swift
//  MWM chors
//
//  Created by Евгений Кириллов on 13.12.2020.
//

struct TextualError: Error {
    private let text: String
}

extension TextualError: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self = TextualError(text: value)
    }
}

extension TextualError: CustomStringConvertible {
    var description: String {
        text
    }
}

extension TextualError: CustomDebugStringConvertible {
    var debugDescription: String {
        "Error: \(description)"
    }
}
