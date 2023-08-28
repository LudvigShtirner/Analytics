import Foundation

/// Протокол, который надо реализовать каждой системе аналитики, участвующей в логировании событий
public protocol AnalyticsEventLogger {
    /// Начальное  **конфигурирование** для системы аналитики
    func configure()
    
    /// Начальное  **конфигурирование** для системы аналитики, при наличии User ID
    func configure(_ userID: String)
    
    /// Установить  User ID для связи с другими сервисами
    func setUserID(_ userID: String)
    
    /// Трекает события без параметров
    ///
    /// - Parameter eventType: Имя события
    func logEvent(_ eventType: String)
    
    /**
     Трекает события с параметрами
     
     ## Note: ##
     outOfSession работает только в некоторых системах аналитики.
     
     - Parameters:
     - eventType: Имя события, которое вы хотите затрекать
     - properties: Вы можете добваить дополнительные параметры как  объект NSDictionary: [String: Any]
     - outOfSession: если YES, будет трекать события за пределами сессии пользователя. Например при работе с пушами.
     */
    func logEvent(_ eventType: String, properties: [String: Any], outOfSession: Bool)
}

extension AnalyticsEventLogger {
    func setUserID(_ userID: String) {}
    
    func logEvent(_ eventType: String) {}
    
    func logEvent(_ eventType: String, properties: [String: Any], outOfSession: Bool) {}
}
