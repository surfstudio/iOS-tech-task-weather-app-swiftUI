//
//  ServiceConstants.swift
//  UnitTests
//

import Foundation

enum ServicesConstants {

    enum Geocoding {
        static let baseUrl = URL(string: "https://rapidapi.p.rapidapi.com/v1")
        static let apiKey = "hTIoM25JEamshVXQzjewnElCOlUHp1I0b48jsnFFFfXwrsTItT"
    }

    enum Weather {
        static let baseUrl = URL(string: "https://r2.mocker.surfstudio.ru/data/2.5")
        static let apiKey = "670f5fe7a475aa3594407d6d17e334f2"
    }
}
