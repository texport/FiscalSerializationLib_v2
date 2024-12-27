//
//  InternalConstructible.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 04.12.2024.
//

protocol InternalConstructible {
    associatedtype InitData
    static func create(with data: InitData) -> Self
}
