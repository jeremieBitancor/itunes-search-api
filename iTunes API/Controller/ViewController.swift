//
//  ViewController.swift
//  Movies
//
//  Created by jeremie bitancor on 5/19/21.
//

import UIKit
import SDWebImage
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var networkManager = NetworkManager()
    var dataManager = DataManager()
    var trackList = [Track]()
    
    let defaults = UserDefaults.standard
    
    let localRealm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /// Choose only one between the two then comment the other choice
        
        /// 1. Option for using the local file
//        dataManager.readLocalFile()
//        dataManager.delegate = self
        
        /// 2. Option for using the server file
        networkManager.fetchTrackData()
        networkManager.delegate = self
        
        /// Register custom cell for TableView
        tableView.register(UINib(nibName: "TrackTableViewCell", bundle: nil), forCellReuseIdentifier: "TrackTableViewCell")
        tableView.dataSource = self

    }

}

//MARK: - Track Manager Delegate

/// Delegate that gets the data from server API
extension ViewController: TrackManagerDelegate {

    ///Get data from protocol
    func didGetTrackList(_ trackList: [Track]) {
        // Set data to local variable
        self.trackList = trackList
        ///Reload the tableview
        tableView.reloadData()
    }

}

//MARK: - Data Manager Delegate

/// Delegate that get data from local file
//extension ViewController: DataManagerDelegate {
    
//    func getSingleTrack(_ track: TrackModelRealm) {
//        
//    }
    
//    func didGetDataFromFile(_ trackList: [Track]) {
//        self.trackList = trackList
//        tableView.reloadData()
//    }
//}

//MARK: - TableView Data Source

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackTableViewCell", for: indexPath) as! TrackTableViewCell

        let track = trackList[indexPath.row]

        cell.trackName.text = track.trackName
        cell.trackGenre.text = track.primaryGenreName
        cell.trackPrice.text = track.priceWithCurrency
        cell.trackImage.sd_setImage(with: URL(string: track.artworkUrl60), placeholderImage: UIImage(systemName: "photo"))

        return cell

    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        /// Get date from user defaults
        guard let date = defaults.object(forKey: "lastVisited") as? Date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: date)
    }
}

//MARK: - TableView Delegate

extension ViewController: UITableViewDelegate {

    /// Method for selecting item from list
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToDetailScreen", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /// Method for sending data to another view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController

        if let indexPath = tableView.indexPathForSelectedRow {

            let track = trackList[indexPath.row]

            destinationVC.track = track
        }
    }
}
