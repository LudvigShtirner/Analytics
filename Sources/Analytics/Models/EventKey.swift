//
//  EventKey.swift
//  
//
//  Created by Алексей Филиппов on 19.08.2023.
//

// Apple
import Foundation

/**
Общий базовый класс для ключей событий Event keys. Нужно использовать extension для строгого описания ключе и их параметров.
 
 ### Пример использования ###
 
 ```
 extension AnalyticsEventKeys {
    static let event = EventKey<EmptyEvent>("Main search tap")
    static let eventWithParameters = EventKey<MyParam>("Event with parameters")
    static let eventWithBool = EventKey<BaseEvent<Bool>>("Event with bool")
 }
 
 Analytics.shared.eventInput.logEvent(.event)
 
 Analytics.shared.eventInput.logEvent(.eventWithBool, propertiesModel: BaseEvent(value: true))
 
 Analytics.shared.eventInput.logEvent(.eventWithParameters, propertiesModel: MyParam(test: "My param", value: 10))
 ```
*/
open class AnalyticsEventKeys {}

/**
 Класс для описания ключей событий.
 ### Пример ключей: ###
     ````
     extension AnalyticsEventKeys {
        static let eventWithParameters = EventKey<MyParam>("Event with parameters")
        static let eventWithBool = EventKey<BaseEvent<Bool>>("Event with bool")
     }
     ````
 */
public class EventKey<PropertiesType: Encodable>: AnalyticsEventKeys {
    public let key: String
    
    public init(_ key: String) {
        self.key = key
    }
}
