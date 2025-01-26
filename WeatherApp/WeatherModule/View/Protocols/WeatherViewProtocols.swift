import UIKit

protocol WeatherViewInput: AnyObject {
    func set(state: WeatherViewState)
    func updateWeather(_ weather: Weather)
}

protocol WeatherViewOutput: AnyObject {
    var weather: Weather? { get set }
    
    func viewDidLoad()
    func searchWeather(for city: String)
}

protocol WeatherView: WeatherViewInput, TransitionHandler {
    var output: WeatherViewOutput! { get set }
}

// MARK: - HomeState

enum WeatherViewState {
    case loading
    case success
    case error(String)
}
