import Foundation
class ModelData: ObservableObject {
    @Published var weatherData: WeatherData?
    private static let defaultForecastFile: String = "london.json"
    private static let defaultAirFile: String = "londonAir.json"
    private static let defaultLocation : String = "Potters Fields Park, London, United Kingdom"
    private static let weatherKey: String = "WeatherData"
    init() {
        loadForecast()
    }
    // TODO: Add Saving and Loading for Air Quality and Location
    
    func downloadData(lat: Double, lon: Double) async throws -> Void {
        let forecastURL = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=0835716d6f39fc54217361ebd0d39a9e")
        let forecastSession = URLSession(configuration: .default)
        let (forecastDownloadData, _) = try await forecastSession.data(from: forecastURL!)
        
        let airURL = URL(string: "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&appid=0835716d6f39fc54217361ebd0d39a9e")
        let airSession = URLSession(configuration: .default)
        let (airDownloadData, _) = try await airSession.data(from: airURL!)
        
        do {
            let forecastData = try JSONDecoder().decode(Forecast.self, from: forecastDownloadData)
            let airData = try JSONDecoder().decode(AirData.self, from: airDownloadData)
            let locationString = await getLocFromLatLong(lat: lat, lon: lon)
            let newWeatherData = WeatherData(location: locationString, forecast: forecastData, air: airData)
            print(newWeatherData.location)
            await self.saveForecast(weatherData: newWeatherData)
            DispatchQueue.main.async {
                self.weatherData = newWeatherData
                self.loadForecast()
            }
        } catch {
            throw error
        }
    }
    
    private func loadForecast() -> Void {
        let forecastData: Data
        let airData: Data
        let decoder = JSONDecoder()
        if let savedWeatherData = UserDefaults.standard.data(forKey: ModelData.weatherKey){
            do {
                let weatherData = try decoder.decode(WeatherData.self, from: savedWeatherData)
                self.weatherData = weatherData
                return
            }
            catch{
            }
        }
        if let file = Bundle.main.url(forResource: ModelData.defaultForecastFile, withExtension: nil),
           let airFile = Bundle.main.url(forResource: ModelData.defaultAirFile, withExtension: nil){
            do {
                forecastData = try Data(contentsOf: file)
                airData = try Data(contentsOf: airFile)
            } catch {
                fatalError("Couldn't load \(ModelData.defaultForecastFile) or \(ModelData.defaultAirFile) from main bundle:\n\(error)")
            }
        }
        else {
            fatalError("Couldn't find \(ModelData.defaultForecastFile) or \(ModelData.weatherKey) in main bundle.")
        }
        do {
            let forecast = try decoder.decode(Forecast.self, from: forecastData)
            let air = try decoder.decode(AirData.self, from: airData)
            self.weatherData = WeatherData(location: ModelData.defaultLocation, forecast: forecast, air: air)
        } catch {
            fatalError("Couldn't parse forecast data as \(Forecast.self):\n\(error)")
        }
    }
    
    private func saveForecast(weatherData: WeatherData) async -> Void {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do{
            let weatherEncoded = try encoder.encode(weatherData)
            UserDefaults.standard.setValue(weatherEncoded, forKey: ModelData.weatherKey)
            UserDefaults.standard.synchronize() // HACK: Fixes saving issue but is deprecated
        }
        catch{
            fatalError("Couldn't encode \(ModelData.defaultForecastFile) as \(weatherData):\n\(error)")
        }
    }
}
