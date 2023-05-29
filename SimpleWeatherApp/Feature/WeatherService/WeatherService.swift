
import Foundation
import Alamofire


protocol WeatherServiceProtocol {
    func getWeatherData(for city: String, completion: @escaping (Result<WeatherData, Error>) -> Void)
}

struct WeatherService: WeatherServiceProtocol {
    func getWeatherData(for city: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let baseURL = "https://api.openweathermap.org/data/2.5/weather"
        let apiKey = "652de512b07adab85bbc6a7711860c4b"
        
        let parameters: [String: String] = [
            "q": city,
            "appid": apiKey
        ]
        
        AF.request(baseURL, parameters: parameters).responseDecodable(of: WeatherData.self) { response in
            if let error = response.error {
                print("API Error: \(error)")
                completion(.failure(error))
                return
            }
            
            if let weatherData = response.value {
                completion(.success(weatherData))
            } else {
                let error = NSError(domain: "WeatherDataError", code: 0, userInfo: nil)
                print("Error: \(error)")
                completion(.failure(error))
            }
        }
    }
}
