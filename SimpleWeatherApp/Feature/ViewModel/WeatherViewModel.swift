
import Foundation

protocol WeatherViewModelDelegate: AnyObject {
    func didFetchWeatherData(weatherData: WeatherData?)
    func didFailWithError(error: Error)
}

class WeatherViewModel {
    weak var delegate: WeatherViewModelDelegate?
    private let weatherService: WeatherServiceProtocol
    
    init() {
        weatherService = WeatherService()
    }
    
    func getWeatherData(for city: String) {
        weatherService.getWeatherData(for: city) { [weak self] result in
            switch result {
            case .success(let weatherData):
                self?.delegate?.didFetchWeatherData(weatherData: weatherData)
            case .failure(let error):
                self?.delegate?.didFailWithError(error: error)
            }
        }
    }
    
}
