//
//  DetailViewController.swift
//  Movies
//
//  Created by jeremie bitancor on 5/19/21.
//

import UIKit
import SDWebImage
import AVKit
import RealmSwift

class DetailViewController: UIViewController {
    
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var trackGenre: UILabel!
    @IBOutlet weak var trackImage: UIImageView!
    @IBOutlet weak var trackReleaseDate: UILabel!
    @IBOutlet weak var trackDuration: UILabel!
    @IBOutlet weak var trackContentRating: UILabel!
    @IBOutlet weak var trackDescription: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    var player = AVPlayer()
    var playerController = AVPlayerViewController()
    
    var track: Track?
    var trackRealm: TrackModelRealm?
    let localRealm = try! Realm()
    
    var dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIElements()
    }
    
    
    /// Update the UI elements
    func updateUIElements() {
        
        /// Check the previous screen and what type of data was sent
        
        /// Perform if previous screen was from All movies
        if track != nil {
            trackName.text = track?.trackName
            trackGenre.text = track?.primaryGenreName
            // TO DO: Update with on loading image
            trackImage.sd_setImage(with: URL(string: track!.artworkUrl100), placeholderImage: UIImage(systemName: "photo"))
            trackDuration.text = "\(track!.convertedDuration) min"
            trackContentRating.text = track?.contentAdvisoryRating
            trackReleaseDate.text = track?.releaseDate
            trackDescription.text = track?.longDescription
            
            if dataManager.isFavorite(track!.trackId) {
                favoriteButton.image = UIImage(systemName: "heart.fill")
            } else {
                favoriteButton.image = UIImage(systemName: "heart")
            }

        }
        /// Perform if previous screen was from Favorite movies
        else {
            trackName.text = trackRealm?.name
            trackGenre.text = trackRealm?.genre
            trackImage.sd_setImage(with: URL(string: trackRealm!.imageUrl100), placeholderImage: UIImage(systemName: "photo"))
            trackDuration.text = "\(trackRealm!.duration) min"
            trackContentRating.text = trackRealm?.contentRating
            trackReleaseDate.text = trackRealm?.releaseDate
            trackDescription.text = trackRealm?.longDescription
            favoriteButton.image = UIImage(systemName: "heart.fill")
        }
       
    }

    @IBAction func playTrailer(_ sender: UIButton) {
        
        var url: String?
        
        if track == nil {
            url =  trackRealm?.previewUrl
        } else {
            url = track?.previewUrl
        }
        
        let videoURL = URL(string: url!)
        player = AVPlayer(url: videoURL!)
        playerController.player = player
        self.present(playerController, animated: true, completion: {
            self.playerController.player?.play()
        })
    }
    
    @IBAction func favoriteTapped(_ sender: UIBarButtonItem) {
        
        if track == nil {
            dataManager.removeFromFavorites(trackRealm!)
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        } else {
            dataManager.realmCrud(track!)
            updateUIElements()
        }
        
    }
    
}

//MARK: - UIRestoring
extension DetailViewController {
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)

        print("encode")
           
        if let safeTrack = track {
            coder.encode(safeTrack.trackId, forKey: "track")
        }
    }

    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)

        print("decode")
        
        guard let decodedTrackID = coder.decodeObject(forKey: "track") as? String else {
            fatalError("Track did not exist.")
        }
        
        track = dataManager.track(fromId: decodedTrackID)
        updateUIElements()

    }
}
