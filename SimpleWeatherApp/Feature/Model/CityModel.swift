

import Foundation
import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let id: Int
    let name, state, country: String
    let coord: Coord
    
    enum CodingKeys: String, CodingKey {
        case id, name, state, country, coord
    }
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
    
    enum CodingKeys: String, CodingKey {
        case lon, lat
    }
}

struct Welcome: Codable {
    let results: [WelcomeElement]
}
