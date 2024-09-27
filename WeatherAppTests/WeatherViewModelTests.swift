//
//  WeatherViewModelTests.swift
//  for WeatherApp
//
//  Created by Iuliia Filimonova on 04.09.2024
//
    
import XCTest
@testable import WeatherApp

/*I'm not satisfied with the tests. I feel more confident with MVP testing.
 I think I could make ViewModel more testable, but it would become less readable, then.
 */
final class WeatherViewModelTests: XCTestCase {
    var mockNetworkManager: MockNetworkManager!
    var sut: AppViewModelProtocol!

    override func setUpWithError() throws {
        mockNetworkManager = MockNetworkManager()
        sut = WeatherViewModel(fetcher: mockNetworkManager)
    }

    override func tearDownWithError() throws {
        mockNetworkManager = nil
        sut = nil
    }
    
    func testWeatherViewModel_WhenCityProvided_ShouldCallFetchData() throws {
        sut.getWeatherByCity("Paris")
        
        XCTAssertTrue(mockNetworkManager.isFetchDataMethodCalled, "FetchData method by city was not called")
    }
    
    func testWeatherViewModel_WhenLocationProvided_ShouldCallFetchData() throws {
        sut.getWeatherByLocation(locationLon: -87.623177, locationLat: 41.881832)
        
        XCTAssertTrue(mockNetworkManager.isFetchDataMethodCalled, "FetchData method by location was not called")
    }
    
    func testWeatherViewModel_WhenCityProvided_CityNameShouldBeSaved() {
        sut.getWeatherByCity("Paris")
        
        XCTAssertEqual(UserDefaults.standard.string(forKey: "cityName"), "Paris", "City name was not saved")
    }
}
