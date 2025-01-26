import Foundation

final class WeatherInteractor {
    
    // MARK: - Connections
    
    weak var output: HomeInteractorOutput?
    
    // MARK: - Services
    
    private let apiService: WeatherAPIServiceType
    private let cacheService: CodableCacheServiceType
    
    // MARK: - Initializer
    
    init(apiService: WeatherAPIServiceType, cacheService: CodableCacheServiceType) {
        self.apiService = apiService
        self.cacheService = cacheService
    }
}

// MARK: - HomeInteractorInput

extension WeatherInteractor: WeatherInteractorInput {
    
    func isFavorite(from weatherId: String) -> Bool {
        cacheService.read(for: weatherId) ?? false
    }
    
    func obtainData(for city: String) {
        Task {
            do {
                let weather = try await apiService.fetchWeather(for: city)
                
                await MainActor.run {
                    output?.set(weather)
                }
            } catch {
                print(error)
                await MainActor.run {
                    output?.handleError(error)
                }
            }
        }
    }
}
