import Foundation

enum WeatherEndpoint: Endpoint {
    case weather(city: String, apiKey: String)
    
    var path: String {
        switch self {
        case .weather(let city, let apiKey):
            return "/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        }
    }
    
    var method: HTTPMethod {
        .GET
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
    
    var body: Data? {
        nil
    }
}
