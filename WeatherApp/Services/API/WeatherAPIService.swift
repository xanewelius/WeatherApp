import Foundation

// MARK: - WeatherAPIServiceType

protocol WeatherAPIServiceType {
    func fetchWeather(for city: String) async throws -> Weather
}

// MARK: - WeatherAPIService

final class WeatherAPIService: WeatherAPIServiceType {
    
    // MARK: - Private properties
    
    private let networkClient: NetworkClient
    private let baseURL: URL
    private let apiKey: String
    
    // MARK: - Initializer
    
    init(networkClient: NetworkClient = DefaultNetworkClient(), baseURL: URL = URL(string: "https://api.openweathermap.org")!, apiKey: String) {
        self.networkClient = networkClient
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
    
    private func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let url = URL(string: endpoint.path, relativeTo: baseURL) else {
            throw APIError.invalidURL
        }
        print("Full URL: \(url.absoluteString)")
        
        let request = NetworkRequest(url: url, method: endpoint.method, headers: endpoint.headers, body: endpoint.body)
        
        return try await networkClient.sendRequest(request)
    }
    
    func fetchWeather(for city: String) async throws -> Weather {
        try await request(WeatherEndpoint.weather(city: city, apiKey: apiKey))
    }
}
