//
//  Array+safe.swift
//  MWM chors
//
//  Created by Евгений Кириллов on 13.12.2020.
//

extension Array {
    subscript(safe index: Int) -> Element? {
        dropFirst(index).first
    }
}
