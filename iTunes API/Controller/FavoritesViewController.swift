//
//  FavoritesViewController.swift
//  Movies
//
//  Created by jeremie bitancor on 5/21/21.
//

import UIKit
import RealmSwift

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataManager = DataManager()
    var tracks: Results<TrackModelRealm>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.delegate = self
        tableView.register(UINib(nibName: "TrackTableViewCell", bundle: nil), forCellReuseIdentifier: "TrackTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataManager.readFileFromRealm()
        tableView.reloadData()
    }

}

//MARK: - TableView Data Source

extension FavoritesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackTableViewCell", for: indexPath) as! TrackTableViewCell

        let track = tracks![indexPath.row]

        cell.trackName.text = track.name
        cell.trackGenre.text = track.genre
        cell.trackPrice.text = track.price
        cell.trackImage.sd_setImage(with: URL(string: track.imageUrl60), placeholderImage: UIImage(systemName: "photo"))

        return cell

    }

}

//MARK: - TableView Delegate

extension FavoritesViewController: UITableViewDelegate {

    /// Method for selecting item from list
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToDetailFromFav", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /// Method for sending data to another view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController

        if let indexPath = tableView.indexPathForSelectedRow {

            let track = tracks![indexPath.row]

            destinationVC.trackRealm = track
        }
    }
}


extension FavoritesViewController: DataManagerDelegate {
    func didGetDataFromFile(_ trackList: Results<TrackModelRealm>) {
        /// Set data
        self.tracks = trackList
    }
    
}
