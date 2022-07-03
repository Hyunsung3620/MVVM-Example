import Foundation

// MARK: - Weather Data Model Struct 구조체
struct WeatherData: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
    let wind: Wind
    let sys: Sys
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
    let gust: Double
}

struct Sys: Decodable {
    let timeZone: Int
    let name: String
}
