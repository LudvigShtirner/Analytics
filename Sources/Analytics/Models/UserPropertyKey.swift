//
//  UserPropertyKey.swift
//  
//
//  Created by Алексей Филиппов on 19.08.2023.
//

import Foundation

/**
 Общий базовый класс для описания User Property ключей. Нужно использовать  extension для строгого описния свойств и их параметров.
 
 ### Пример использования ###
 ````
 extension AnalyticsUserProperyKeys {
    static let firstLaunch = UserPropertyKey<String>("first_launch_week", mutability: .unmutable)
    static let mutableProperty = UserPropertyKey<String>("mutable_property")
    static let purchaseCounter = UserPropertyKey<Int>("counter")
 }
 
 Analytics.shared.userDataInput.set(value: "2017.20", key: .firstLaunch)
 
 Analytics.shared.userDataInput.set(value: "Turn on", key: .mutableProperty)
 
 Analytics.shared.userDataInput.add(value: 2, key: .purchaseCounter)
 
 ````
 */
open class AnalyticsUserPropertyKeys {}

/**
Описывает ключ для пользовательского свойства

### Пример создания ключа: ###
````
extension AnalyticsUserPropertyKeys {
    static let purchaseCounter = UserPropertyKey<Int>("counter")
}
````
*/
public class UserPropertyKey<ValueType: LosslessStringConvertible> {
    
    /// Определяет можно ли изменять свойство после первой установки
    public enum PropertyMutability {
        case unmutable
        case mutable
    }
    
    public let key: String
    public let mutability: PropertyMutability
    
    public init(_ key: String, mutability: PropertyMutability = .mutable) {
        self.key = key
        self.mutability = mutability
    }
}
