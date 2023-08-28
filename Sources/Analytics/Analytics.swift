// Apple
import Foundation

/// Общий класс-обертка, используемый как singleton для вызова событий аналтики
public final class Analytics {
    // MARK: - Private Info
    var eventLoggers: [AnalyticsEventLogger] = []
    var userDataDirectors: [AnalyticsUserDataDirector] = []
    
    // MARK: - Singleton
    static let shared = Analytics()
    
    private init() {}
}
