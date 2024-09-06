//
//  WeatherDataTests.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 05.09.2024
//
    

import XCTest
@testable import WeatherApp

class WeatherDataTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func test_CanParseWeatherData() throws {
        let json = """
           {
             "coord": {
               "lon": 10.99,
               "lat": 44.34
             },
             "weather": [
               {
                 "id": 501,
                 "main": "Rain",
                 "description": "moderate rain",
                 "icon": "10d"
               }
             ],
             "base": "stations",
             "main": {
               "temp": 298.48,
               "feels_like": 298.74,
               "temp_min": 297.56,
               "temp_max": 300.05,
               "pressure": 1015,
               "humidity": 64,
               "sea_level": 1015,
               "grnd_level": 933
             },
             "visibility": 10000,
             "wind": {
               "speed": 0.62,
               "deg": 349,
               "gust": 1.18
             },
             "rain": {
               "1h": 3.16
             },
             "clouds": {
               "all": 100
             },
             "dt": 1661870592,
             "sys": {
               "type": 2,
               "id": 2075663,
               "country": "IT",
               "sunrise": 1661834187,
               "sunset": 1661882248
             },
             "timezone": 7200,
             "id": 3163858,
             "name": "Zocca",
             "cod": 200
           }
        """

        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()

        let result = try decoder.decode(WeatherData.self, from: data)

        XCTAssertEqual(result.name, "Zocca")
        XCTAssertEqual(result.main.temp, 298.48)
        XCTAssertNotNil(result.weather.first?.icon)
    }
}

