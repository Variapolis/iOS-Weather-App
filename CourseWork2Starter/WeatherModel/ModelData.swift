import Foundation
class ModelData: ObservableObject {
    @Published var weatherData: WeatherData?
    private let defaultForecastFile: String = "london.json"
    private let defaultAirFile: String = "londonAir.json"
    private let defaultLocation : String = "Potters Fields Park, London, United Kingdom"
    private let weatherKey: String = "weather"
    init() {
        loadForecast()
    }
    // TODO: Add Saving and Loading for Air Quality and Location
    
    func downloadData(lat: Double, lon: Double) async throws -> WeatherData {
        let weatherURL = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=0835716d6f39fc54217361ebd0d39a9e")
        let weatherSession = URLSession(configuration: .default)
        let (weatherData, _) = try await weatherSession.data(from: weatherURL!)
        
        let airURL = URL(string: "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&appid=0835716d6f39fc54217361ebd0d39a9e")
        let airSession = URLSession(configuration: .default)
        let (airData, _) = try await airSession.data(from: airURL!)
        
        do {
            //print(data)
            let forecastData = try JSONDecoder().decode(Forecast.self, from: weatherData)
            let airData = try JSONDecoder().decode(AirData.self, from: airData)
            let locationString = await getLocFromLatLong(lat: lat, lon: lon)
            let newWeatherData = WeatherData(location: locationString, forecast: forecastData, air: airData)
            DispatchQueue.main.async {
                self.weatherData = newWeatherData
                self.saveForecast(weatherData: newWeatherData)
                print("Saving")
            }
            return newWeatherData
        } catch {
            throw error
        }
    }
        
    private func loadForecast() -> Void {
        let forecastData: Data
        let airData: Data
        let decoder = JSONDecoder()
        let userDefaults = UserDefaults.standard
        if let savedWeatherData = userDefaults.data(forKey: weatherKey){
            do {
                let weatherData = try decoder.decode(WeatherData.self, from: savedWeatherData)
                self.weatherData = weatherData
                return
            }
            catch{            
            }
            print("Save File not found")
        }
        if let file = Bundle.main.url(forResource: defaultForecastFile, withExtension: nil),
                    let airFile = Bundle.main.url(forResource: defaultAirFile, withExtension: nil){
            do {
                forecastData = try Data(contentsOf: file)
                airData = try Data(contentsOf: airFile)
            } catch {
                fatalError("Couldn't load \(defaultForecastFile) or \(defaultAirFile) from main bundle:\n\(error)")
            }
        }
        else {
            fatalError("Couldn't find \(defaultForecastFile) or \(weatherKey) in main bundle.")
        }
        do {
            let forecast = try decoder.decode(Forecast.self, from: forecastData)
            let air = try decoder.decode(AirData.self, from: airData)
            self.weatherData = WeatherData(location: defaultLocation, forecast: forecast, air: air)
        } catch {
            fatalError("Couldn't parse forecast data as \(Forecast.self):\n\(error)")
        }
    }
    
    private func saveForecast(weatherData: WeatherData) -> Void {
        let encoder = JSONEncoder()
        let userDefaults = UserDefaults.standard
        encoder.outputFormatting = .prettyPrinted
        do{
            let weatherEncoded = try encoder.encode(weatherData)
            userDefaults.set(weatherEncoded, forKey: weatherKey)
            print("Saved")
        }
        catch{
            fatalError("Couldn't encode \(defaultForecastFile) as \(weatherData):\n\(error)")
        }
    }
}
