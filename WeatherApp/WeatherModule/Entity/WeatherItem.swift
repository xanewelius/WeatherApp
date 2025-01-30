import Foundation

enum WeatherItem {
    case windSpeed(Double)
    case cloudiness(Int)
    case temperature(Double)
    case minTemperature(Double)
    case maxTemperature(Double)
    case visibility(Int)
    
    var name: String {
        switch self {
        case .windSpeed: return "WIND SPEED"
        case .cloudiness: return "CLOUDINESS"
        case .temperature: return "TEMPERATURE"
        case .minTemperature: return "MIN TEMPERATURE"
        case .maxTemperature: return "MAX TEMPERATURE"
        case .visibility: return "VISIBILITY"
        }
    }
    
    var info: String {
        switch self {
        case .windSpeed(let speed): return "\(speed) m/s"
        case .cloudiness(let cloud): return "\(cloud)%"
        case .temperature(let temp): return "\(temp)°"
        case .minTemperature(let temp): return "\(temp)°"
        case .maxTemperature(let temp): return "\(temp)°"
        case .visibility(let value): return "\(value / 1000) km"
        }
    }
    
    var progress: Float {
        switch self {
        case .windSpeed(let speed):
            return Float(min(max((speed / 15), 0), 1))
        case .cloudiness(let cloud):
            return Float(cloud) / 100
        case .temperature(let temp):
            return Float(min(max((temp / 15), 0), 1))
        case .minTemperature(let temp):
            return Float(min(max((temp / 15), 0), 1))
        case .maxTemperature(let temp):
            return Float(min(max((temp / 15), 0), 1))
        case .visibility(let value):
            return Float(value / 100) / 100
        }
    }
}
