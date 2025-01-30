import Foundation

final class WeatherRouter {
    
    // MARK: - Connections
    
    private unowned var transitionHandler: TransitionHandler
    
    // MARK: - Initializer
    
    init(transitionHandler: TransitionHandler) {
        self.transitionHandler = transitionHandler
    }
}

// MARK: - HomeRouterInput

extension WeatherRouter: WeatherRouterInput {}
