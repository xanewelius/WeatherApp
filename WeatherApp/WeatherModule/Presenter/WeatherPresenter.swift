import UIKit

enum Section: Int, CaseIterable {
    case header
    case time
    case weather
    case humidity
}

final class WeatherPresenter {
    
    // MARK: - Connections
    
    private unowned var view: WeatherViewInput
    
    private let interactor: WeatherInteractorInput
    private let router: WeatherRouterInput
    
    var weather: Weather?
    
    // MARK: - Initializer
    
    init(view: WeatherViewInput, interactor: WeatherInteractorInput, router: WeatherRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - HomeViewOutput

extension WeatherPresenter: WeatherViewOutput {
    
    func viewDidLoad() {
        view.set(state: .loading)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.interactor.obtainData(for: "Бахчисарай")
        }
    }
    
    func sendRequest() {
        view.set(state: .loading)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.interactor.obtainData(for: "Бахчисарай")
        }
    }
    
    func searchWeather(for city: String) {
        view.set(state: .loading)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.interactor.obtainData(for: city)
        }
    }
}

// MARK: - HomeInteractorOutput

extension WeatherPresenter: HomeInteractorOutput {
    
    func set(_ weather: Weather) {
        self.weather = weather
        view.set(state: .success)
        view.updateWeather(weather)
    }
    
    func handleError(_ error: any Error) {
        let state: WeatherViewState
        
        if let apiError = error as? APIError {
            switch apiError {
            case .invalidURL:
                state = .error("Invalid URL")
            case .invalidReponse(let statusCode):
                if statusCode == 401 {
                    return
                } else {
                    state = .error("Invalid response, status code: \(statusCode)")
                }
            case .decoding(let decodingError):
                state = .error("Decoding error: \(decodingError.localizedDescription)")
            case .network(let error):
                state = .error("Network error: \(error.localizedDescription)")
            }
        } else {
            state = .error("Unknown error: \(error.localizedDescription)")
        }
        
        view.set(state: state)
    }
}
