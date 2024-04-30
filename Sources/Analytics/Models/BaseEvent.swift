//
//  BaseEvent.swift
//  
//
//  Created by Алексей Филиппов on 19.08.2023.
//

// Apple
import Foundation

/// Базовая модель для обертки примитивов, таких как:  String, Int, Bool, и т.д.
public struct BaseEvent<T: Encodable>: Encodable {
    var value: T
}
