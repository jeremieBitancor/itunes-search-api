//
//  TrackModel.swift
//  Movies
//
//  Created by jeremie bitancor on 5/19/21.
//

import Foundation

struct TrackList: Codable {
    let results: [Track]
}

struct Track: Codable {
    
    var trackPriceString: String {
        return String(format: "%.2f", trackPrice)
    }
    
    var priceWithCurrency: String {
        return "\(currency) \(trackPriceString)"
    }
    
    var convertedDuration: String {
        let cd = Double(trackTimeMillis) / Double(60000)
        return String(format: "%.0f", cd)
    }
    
    var formattedDate: String {
        
        // Convert ISO string to Date
        let df = ISO8601DateFormatter()
        let date = df.date(from:releaseDate)!
        
        // Format Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MMM dd"
        
        return dateFormatter.string(from: date)

    }
    
    let trackId: Int
    let trackName: String
    let trackPrice: Double
    let primaryGenreName: String
    let longDescription: String
    let releaseDate: String
    let currency: String
    let artworkUrl60: String
    let artworkUrl100: String
    let previewUrl: String
    let trackTimeMillis: Int
    let contentAdvisoryRating: String
}
