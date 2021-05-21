//
//  DataManager.swift
//  Movies
//
//  Created by jeremie bitancor on 5/20/21.
//

import Foundation
import RealmSwift

protocol DataManagerDelegate {
    func didGetDataFromFile(_ trackList: Results<TrackModelRealm>)
//    func getSingleTrack(_ track: TrackModelRealm)
}

class DataManager {
    
    let localRealm = try! Realm()
    var delegate: DataManagerDelegate?
    var tracks = [Track]()
    
    /// Read local file of the API
    
    func readLocalFile() {
        do {
            if let bundlePath = Bundle.main.path(forResource: "tracks", ofType: "json"){
                guard let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) else { return  } 
                parse(jsonData: jsonData)
            }
        } catch {
            print("Error reading file, \(error)")
        }
    }
    
    /// Parse the data
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(TrackList.self, from: jsonData)
            tracks = decodedData.results
            DispatchQueue.main.async {
//                self.delegate?.didGetDataFromFile(decodedData.results)
            }
        } catch {
            print("Error parsing data. \(error)")
        }
    }

    /// Selecting the a single track from the track list on the local version
    func track(fromId: String) -> Track? {
        
        let fp = tracks.filter { pr in
            let pi = String(pr.trackId)
            if pi == "1437031362" { return true } else { return false }
        }
        if fp.isEmpty {
            fatalError("Can't find identifier")
        }
        
        print("Name: \(fp[0].trackName)")
        return fp[0]
    }
    
    func readFileFromRealm() {
        let tracks = localRealm.objects(TrackModelRealm.self)
        
        self.delegate?.didGetDataFromFile(tracks)
        
    }
    
    /// Realm data manipulation, saves data when the user click on favorite and remove it when click again.
    func realmCrud(_ track: Track) {
        
        /// Convert data from TrackModel to TrackRealmModel
        let convertedTrack = TrackModelRealm(id: track.trackId, name: track.trackName, genre: track.primaryGenreName, imageUrl100: track.artworkUrl100, imageUrl60: track.artworkUrl60,duration: track.convertedDuration, contentRating: track.contentAdvisoryRating, releaseDate: track.releaseDate, description: track.longDescription, previewUrl: track.previewUrl, price: track.priceWithCurrency)
        
        if isFavorite(track.trackId) {
            do {
               removeFromFavorites(convertedTrack)
            }
        } else {
            do {
                /// Add data to realm
                try localRealm.write{
                    localRealm.add(convertedTrack)
                    print("Track saved.")
                }
            } catch {
                print("Error saving, \(error)")
            }
        }
    }
    
    /// Removes data from realm
    func removeFromFavorites(_ track: TrackModelRealm) {
        
        if let selectedTrack = localRealm.object(ofType: TrackModelRealm.self, forPrimaryKey: track.id) {
            do {
                try localRealm.write {
                    localRealm.delete(selectedTrack)
                    print("Track removed.")
                }
            } catch {
                print("Error removing from favorites, \(error)")
            }
        }
        
      
    }
    
    /// Check if data is favorite or not
    func isFavorite(_ id: Int) -> Bool {
        
        let selectedTrack = localRealm.object(ofType: TrackModelRealm.self, forPrimaryKey: String(id))
        if selectedTrack != nil {
            return true

        } else {
            return false
        }
    }
    
}

