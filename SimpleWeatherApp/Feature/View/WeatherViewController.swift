
import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet var lineView3: UIView!
    @IBOutlet var lineView2: UIView!
    @IBOutlet var lineView: UIView!
    @IBOutlet var coordView: UIView!
    @IBOutlet var seaLevelView: UIView!
    @IBOutlet var windView: UIView!
    @IBOutlet var humidityView: UIView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var feelsLikeLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var windGustLabel: UILabel!
    @IBOutlet var seaLabel: UILabel!
    @IBOutlet var coordLatLabel: UILabel!
    @IBOutlet var coordLongLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var tempMaxLabel: UILabel!
    @IBOutlet var tempMinLabel: UILabel!
    var weatherViewModel: WeatherViewModel!
    var selectedCity: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherViewModel = WeatherViewModel()
        configureBubbleViews()
        weatherViewModel.delegate = self
        if let selectedCity = selectedCity {
            weatherViewModel.getWeatherData(for: selectedCity)
        }
    }
    private func configureBubbleViews() {
        humidityView.layer.cornerRadius = humidityView.bounds.width / 18
        humidityView.layer.borderColor = UIColor.gray.cgColor
        humidityView.layer.borderWidth = 2.0
        humidityView.layer.masksToBounds = true
        
        
        windView.layer.cornerRadius = windView.bounds.width / 12
        windView.layer.borderColor = UIColor.gray.cgColor
        windView.layer.borderWidth = 2.0
        windView.layer.masksToBounds = true
        
        seaLevelView.layer.cornerRadius = seaLevelView.bounds.width / 16
        seaLevelView.layer.borderColor = UIColor.gray.cgColor
        seaLevelView.layer.borderWidth = 2.0
        seaLevelView.layer.masksToBounds = true
        
        coordView.layer.cornerRadius = coordView.bounds.width / 10
        coordView.layer.borderColor = UIColor.gray.cgColor
        coordView.layer.borderWidth = 2.0
        coordView.layer.masksToBounds = true
        
        lineView.backgroundColor = .gray
        lineView2.backgroundColor = .gray
        lineView3.backgroundColor = .gray
    }
    
    func getWeatherData() {
        guard let selectedCity = selectedCity else {
            print("Selected city is nil.")
            return
        }
        
        weatherViewModel = WeatherViewModel()
        weatherViewModel.delegate = self
        weatherViewModel.getWeatherData(for: selectedCity)
    }
    
}
extension WeatherViewController: WeatherViewModelDelegate {
    
    func didFetchWeatherData(weatherData: WeatherData?) {
        if let weatherData = weatherData {
            DispatchQueue.main.async { [weak self] in
                self?.temperatureLabel.text = "\(Int(weatherData.main.temp - 273.15))°C"
                self?.cityNameLabel.text = weatherData.name
                self?.feelsLikeLabel.text = "\(Int(weatherData.main.feelsLike - 273.15))°C"
                self?.humidityLabel.text = "% \(String(weatherData.main.humidity))"
                self?.windSpeedLabel.text = "Speed: \(String(weatherData.wind.speed)) km/h"
                self?.windGustLabel.text = "Gust: \(String(weatherData.wind.deg)) km/h"
                self?.coordLatLabel.text = "Latitude: \(String(format: "%.0f", weatherData.coord.lat))"
                self?.coordLongLabel.text = "Longitude: \(String(format: "%.0f", weatherData.coord.lon))"
                self?.tempMinLabel.text = "\(Int(weatherData.main.tempMin - 273.15))°C"
                self?.tempMaxLabel.text = "\(Int(weatherData.main.tempMax - 273.15))°C"
                self?.descriptionLabel.text = weatherData.weather.first?.weatherDescription
                self?.seaLabel.text = String(weatherData.main.pressure)
                
            }
        } else {
            print("Error!")
        }
    }
    
    func didFailWithError(error: Error) {
        print("Error: \(error)")
    }
}
