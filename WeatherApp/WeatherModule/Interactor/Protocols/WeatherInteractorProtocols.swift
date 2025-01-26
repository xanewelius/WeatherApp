import Foundation

protocol WeatherInteractorInput: AnyObject {
    func obtainData(for city: String)
    func isFavorite(from weatherId: String) -> Bool
}

protocol HomeInteractorOutput: AnyObject {
    func set(_ weather: Weather)
    func handleError(_ error: Error)
}
