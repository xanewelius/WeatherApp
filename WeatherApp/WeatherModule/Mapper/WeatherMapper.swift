import UIKit

final class WeatherMapper {
    
    static func mapToDisplayWeather(from weather: Weather) -> DisplayWeather {
        return DisplayWeather(
            cityId: weather.id,
            cityName: weather.name,
            temperature: "\(Int(weather.main.temp))°C",
            description: weather.weather.first?.description.capitalized ?? "",
            humidity: "Humidity: \(weather.main.humidity)%",
            windSpeed: "Wind: \(weather.wind.speed) m/s",
            iconURL: URL(string: "https://openweathermap.org/img/wn/\(weather.weather.first?.icon ?? "01d")@2x.png")
        )
    }

    static func mapToDisplayHeader(from weather: Weather) -> DisplayHeader {
        let cityName = weather.name
        let weatherDescription = "NOW \(weather.weather.first?.description.uppercased() ?? "")"
        
        let date = Date(timeIntervalSince1970: TimeInterval(weather.dt + weather.timezone))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/M/yyyy"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let formattedDate = dateFormatter.string(from: date)
        
        return DisplayHeader(
            cityName: cityName,
            weatherDescription: weatherDescription,
            formattedDate: formattedDate
        )
    }

    static func mapToDisplayTime(from weather: Weather) -> DisplayTime {
        let date = Date(timeIntervalSince1970: TimeInterval(weather.dt + weather.timezone))
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        timeFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let formattedTime = timeFormatter.string(from: date)
        let timeComponents = formattedTime.split(separator: " ")
        let timePart = String(timeComponents[0])
        let amPmPart = String(timeComponents[1]).lowercased()
        let attributedString = NSMutableAttributedString(string: "\(timePart)\(amPmPart)")
        let range = (attributedString.string as NSString).range(of: amPmPart)
        attributedString.addAttribute(.font, value: UIFont.monospacedDigitSystemFont(ofSize: 18, weight: .light), range: range)
        attributedString.addAttribute(.foregroundColor, value: UIColor.secondaryLabel, range: range)
        
        let imageURL = URL(string: "https://openweathermap.org/img/wn/\(weather.weather.first?.icon ?? "10d")@4x.png")
        
        return DisplayTime(
            time: attributedString,
            imageURL: imageURL
        )
    }
    
    static func mapToWeatherItem(from weather: Weather) -> [WeatherItem] {
        return [
            .windSpeed(weather.wind.speed),
            .temperature(weather.main.temp),
            .cloudiness(weather.clouds.all),
            .minTemperature(weather.main.tempMin),
            .visibility(weather.visibility),
            .maxTemperature(weather.main.tempMax)
        ]
    }
    
    static func mapToDisplayHumidity(from weather: Weather) -> DisplayHumidity {
        let humidity = "% Humidity"
        let progress = Float(weather.main.humidity) / 100
        
        return DisplayHumidity(
            humidity: humidity,
            progress: progress
        )
    }
}
