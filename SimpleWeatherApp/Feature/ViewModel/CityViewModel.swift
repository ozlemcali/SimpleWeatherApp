
import Foundation

protocol CityViewModelDelegate: AnyObject {
    func didFetchCityList(cityList: [WelcomeElement])
    func didFailWithError(error: Error)
}

class CityViewModel {
    weak var delegate: CityViewModelDelegate?
    var cityList = [WelcomeElement]()
    
    func getCityList() {
        guard let fileLocation = Bundle.main.url(forResource: "citylist", withExtension: "json") else {
            delegate?.didFailWithError(error: NSError(domain: "FileNotFound", code: 0, userInfo: nil))
            return
        }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            let receivedData = try JSONDecoder().decode([WelcomeElement].self, from: data)
            cityList = receivedData
            delegate?.didFetchCityList(cityList: receivedData) 
        } catch {
            delegate?.didFailWithError(error: error)
        }
    }
    
    func filterCityList(with searchText: String) {
        let filteredCities = cityList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        delegate?.didFetchCityList(cityList: filteredCities)
    }
    
    
    
}


