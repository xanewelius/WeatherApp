import UIKit

// MARK: - VIPER Components

// MARK: - WeatherViewProtocol
protocol WeatherViewProtocol: AnyObject {
    func displayWeather(_ weather: Weather)
    func displayError(_ error: String)
}

// MARK: - WeatherPresenterProtocol
protocol WeatherPresenterProtocol: AnyObject {
    func viewDidLoad()
    func fetchWeather(for city: String)
}

// MARK: - WeatherInteractorProtocol
protocol WeatherInteractorProtocol: AnyObject {
    func fetchWeather(for city: String) async throws -> Weather
}

// MARK: - WeatherRouterProtocol
protocol WeatherRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

// MARK: - WeatherPresenter
final class WeatherPresenters: WeatherPresenterProtocol {
    weak var view: WeatherViewProtocol?
    var interactor: WeatherInteractorProtocol?
    var router: WeatherRouterProtocol?
    
    func viewDidLoad() {
        // Example of initial fetch
        fetchWeather(for: "Мурино")
    }
    
    func fetchWeather(for city: String) {
        Task {
            do {
                let weather = try await interactor?.fetchWeather(for: city)
                if let weather = weather {
                    view?.displayWeather(weather)
                }
            } catch {
                view?.displayError(error.localizedDescription)
            }
        }
    }
}

// MARK: - WeatherInteractor
final class WeatherInteractors: WeatherInteractorProtocol {
    private let weatherService: WeatherAPIServiceType
    
    init(weatherService: WeatherAPIServiceType) {
        self.weatherService = weatherService
    }
    
    func fetchWeather(for city: String) async throws -> Weather {
        try await weatherService.fetchWeather(for: city)
    }
}

// MARK: - WeatherRouter
final class WeatherRouters: WeatherRouterProtocol {
    static func createModule() -> UIViewController {
        let view = WeatherViewControllers()
        let presenter = WeatherPresenters()
        let interactor = WeatherInteractors(weatherService: WeatherAPIService(apiKey: "9da20e4fae41218664c682af6988d532"))
        let router = WeatherRouters()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
}

// MARK: - WeatherViewController
final class WeatherViewControllers: UIViewController, WeatherViewProtocol {
    var presenter: WeatherPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func displayWeather(_ weather: Weather) {
        print("Weather: \(weather)")
    }
    
    func displayError(_ error: String) {
        print("Error: \(error)")
    }
}

