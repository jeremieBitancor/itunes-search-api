//
//  NetworkManager.swift
//  Movies
//
//  Created by jeremie bitancor on 5/19/21.
//

import Foundation

/// Delegation for sending data to controller
protocol TrackManagerDelegate {
    func didGetTrackList(_ trackList: [Track])
}

class NetworkManager {
    
    var delegate: TrackManagerDelegate?
    
    /// Get data from API
    func fetchTrackData() {
        if let url = URL(string: "https://itunes.apple.com/search?term=star&country=au&media=movie&all") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {( data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            // Decode api to Model
                            let results = try decoder.decode(TrackList.self, from: safeData)
                            DispatchQueue.main.async {
                                // Set data using delegation
                                self.delegate?.didGetTrackList(results.results)
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
