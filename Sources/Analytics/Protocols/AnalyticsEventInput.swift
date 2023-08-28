//
//  AnalyticsEventInput.swift
//  
//
//  Created by Алексей Филиппов on 19.08.2023.
//

import Foundation

/// Протокол для обработки входящих операций над событиями  для системы аналитики
public protocol AnalyticsEventInput {
    /**
    Логирует событие без параметров
     
    ## Note ##
    Используйтеу **EmtpyEvent** модель для событий без параметров для стогой типизации.
     
    ### Пример ключа: ###
    ````
    extension AnalyticsEventKeys {
        static let mainSearchTap = EventsKeys<EmptyEvent>("Main search tap")
    }
    ````
     
    - Parameters:
        - eventKey : Ключ события, описывается как static let в  **AnalyticsEventKeys**.
     
    */
    func logEvent(_ eventKey: EventKey<EmptyEvent>)
    
    /**
   
     
     ## Note ##
     Используйте  **BaseEvent** модель для событий с параметрами такими как  String, Int, Bool, и т.д.
     
     ### Пример ключей: ###
     ````
     extension AnalyticsEventKeys {
        static let eventWithParameters = EventKey<MyParam>("Event with parameters")
        static let eventWithBool = EventKey<BaseEvent<Bool>>("Event with bool")
     }
     ````
     
     - Parameters:
        - eventKey: Ключ события, описывается как static let в  **AnalyticsEventKeys**.
        - propertiesModel: Модель, описывающая параметры события
     
    */
    func logEvent<T>(_ eventKey: EventKey<T>, propertiesModel: T) where T: Encodable
    
    /**
    Логирует событие с параметрами, описанными как модель
     
     ## Note ##
     Используйте  **BaseEvent** модель для событий с параметрами такими как  String, Int, Bool, и т.д.
     
     ### Пример ключей: ###
     ````
     extension AnalyticsEventKeys {
        static let eventWithParameters = EventKey<MyParam>("Event with parameters")
        static let eventWithBool = EventKey<BaseEvent<Bool>>("Event with bool")
     }
     ````
     
     - Parameters:
        - eventKey: Ключ события, описывается как static let в  **AnalyticsEventKeys**
        - propertiesModel: Модель, описывающая параметры события
        - outOfSession: Если YES, будет залогировано как событие вне сессии.
     Полезно для событий связанных, к примеру с пуш уведомлениями. (**Работает только в Amplitude на 12.06.2019**)
     
     */
    func logEvent<T>(_ eventKey: EventKey<T>, propertiesModel: T, outOfSession: Bool) where T: Encodable
}

// MARK: - AnalyticsEventsInput
extension Analytics: AnalyticsEventInput {
    public class var eventInput: AnalyticsEventInput {
        return shared
    }
    
    // MARK: - Analytics Events
    public func logEvent<T: Encodable>(_ eventKey: EventKey<T>) {
        eventLoggers.forEach { $0.logEvent(eventKey.key) }
    }
    
    public func logEvent<T>(_ eventKey: EventKey<T>,
                            propertiesModel: T) where T: Encodable {
        logEvent(eventKey, propertiesModel: propertiesModel, outOfSession: false)
    }
    
    public func logEvent<T: Encodable>(_ eventKey: EventKey<T>,
                                       propertiesModel: T,
                                       outOfSession: Bool = false) {
        let encoder = DictionaryEncoder()
        do {
            let properties: [String: Any] = try encoder.encode(propertiesModel)
            eventLoggers.forEach { $0.logEvent(eventKey.key, properties: properties, outOfSession: outOfSession) }
        } catch {
            fatalError("Error! Encoding for model of user propery. \(propertiesModel)")
        }
    }
}
