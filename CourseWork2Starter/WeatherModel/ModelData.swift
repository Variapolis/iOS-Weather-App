import Foundation
class ModelData: ObservableObject {
    @Published var forecast: Forecast?
    @Published var airData: AirData?
    @Published  var userLocation: String = ""
    let defaultFilename: String = "london.json"
    let runtimeDataKey: String = "weather"
    init() {
        self.forecast = loadForecast()
    }
    
    
    func downloadData(lat: Double, lon: Double) async throws -> Forecast {
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
            DispatchQueue.main.async {
                self.forecast = forecastData
                self.airData = airData
                self.userLocation = locationString
            }
            self.saveForecast(forecastData: forecastData)
            return forecastData
        } catch {
            throw error
        }
    }
    
    func loadForecast<Forecast: Decodable>() -> Forecast {
        let data: Data
        let decoder = JSONDecoder()
        let userDefaults = UserDefaults.standard
        if let savedData = userDefaults.data(forKey: runtimeDataKey){
            data = savedData
        }
        else if let file = Bundle.main.url(forResource: defaultFilename, withExtension: nil){
            do {
                data = try Data(contentsOf: file)
            } catch {
                fatalError("Couldn't load \(defaultFilename) from main bundle:\n\(error)")
            }
        }
        else {
            fatalError("Couldn't find \(defaultFilename) or \(runtimeDataKey) in main bundle.")
        }
        do {
            return try decoder.decode(Forecast.self, from: data)
        } catch {
            fatalError("Couldn't parse forecast data as \(Forecast.self):\n\(error)")
        }
    }
    
    func saveForecast(forecastData: Forecast) -> Void {
        let encoder = JSONEncoder()
        let userDefaults = UserDefaults.standard
        encoder.outputFormatting = .prettyPrinted
        do{
            let dataToSave = try encoder.encode(forecastData)
            userDefaults.set(dataToSave, forKey: runtimeDataKey)
        }
        catch{
            fatalError("Couldn't encode \(defaultFilename) as \(forecastData):\n\(error)")
        }
    }
}
