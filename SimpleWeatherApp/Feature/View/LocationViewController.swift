
import UIKit

class LocationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    var cityList: [WelcomeElement] = [WelcomeElement]()
    var cityViewModel = CityViewModel()
    var weatherViewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchTextField.delegate = self
        cityViewModel.delegate = self
        cityViewModel.getCityList()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! LocationViewCell
        cell.textLabel?.text = cityList[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    @IBAction func searchPressed(_ sender: Any) {
        searchTextField.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = cityList[indexPath.row].name
        weatherViewModel.getWeatherData(for: selectedCity)
        if let tabBarController = tabBarController, let viewControllers = tabBarController.viewControllers {
            if let weatherViewController = viewControllers[1] as? WeatherViewController {
                weatherViewController.selectedCity = selectedCity
                tabBarController.selectedIndex = 1
                weatherViewController.getWeatherData()
            }
        }
    }
    
}

extension LocationViewController: CityViewModelDelegate {
    func didFetchCityList(cityList: [WelcomeElement]) {
        self.cityList = cityList
        tableView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
}


extension LocationViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let searchText = searchTextField.text, !searchText.isEmpty {
            cityViewModel.filterCityList(with: searchText)
        } else {
            
            cityViewModel.delegate?.didFetchCityList(cityList: cityViewModel.cityList)
        }
        
        searchTextField.text = ""
    }
    
}
