import Foundation

protocol WeatherRouterInput: AnyObject {
    func presentDetails(with shipId: String, presenter: WeatherPresenter) -> ShipDetailsModuleInput
}
