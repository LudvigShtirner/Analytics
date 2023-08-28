//
//  AnalyticsConfigurator.swift
//  
//
//  Created by Алексей Филиппов on 20.08.2023.
//

// Apple
import Foundation

/// Обертка над системой аналитики
public protocol AnalyticsConfigurator: AnyObject {
    /**
    Добавление обработчика событий аналитики
     
    ## Note ##
     Определить всех обработичков нужно до вызова метода configureAll()
    
     - Parameters:
        - handler: сущность реализующая  **AnalyticEventHandler**
        - userID: пользовательский идентификатор.
     
    */
    func addEventLogger(_ logger: AnalyticsEventLogger,
                        userID: String)
    
    /**
     Добавление обработчика свойств пользоватлея
     
    ## Note ##
     Определить всех обработичков нужно до вызова метода configureAll()
     
     - Parameters:
        - handler: сущность реализующая  **AnalyticsUserPropertiesHandler**
     
     */
    func addUserDataDirector(_ director: AnalyticsUserDataDirector)
}

extension Analytics: AnalyticsConfigurator {
    public class var configurator: AnalyticsConfigurator {
        return shared
    }
    
    // MARK: - Configuration
    public func addEventLogger(_ logger: AnalyticsEventLogger, userID: String) {
        eventLoggers.append(logger)
        logger.configure(userID)
    }
    
    public func addUserDataDirector(_ director: AnalyticsUserDataDirector) {
        userDataDirectors.append(director)
    }
}
