import Foundation

final class WeatherAssembly {
    
    static func assembly(with view: WeatherView) {
        let apiService = WeatherAPIService(apiKey: "9da20e4fae41218664c682af6988d532")
        let cacheService = CacheService()
        let interactor = WeatherInteractor(apiService: apiService, cacheService: cacheService)
        let router = WeatherRouter(transitionHandler: view)
        let presenter = WeatherPresenter(view: view, interactor: interactor, router: router)
        
        view.output = presenter
        interactor.output = presenter
    }
}
