//
//  TrackModelRealm.swift
//  Movies
//
//  Created by jeremie bitancor on 5/20/21.
//

import Foundation
import RealmSwift

class TrackModelRealm: Object, Codable {
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var genre: String = ""
    @objc dynamic var imageUrl100: String = ""
    @objc dynamic var imageUrl60: String = ""
    @objc dynamic var duration: String = ""
    @objc dynamic var contentRating: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var longDescription: String = ""
    @objc dynamic var previewUrl: String = ""
    @objc dynamic var isFavorite: Bool = false
    @objc dynamic var price: String = ""
    
    convenience init(id:Int ,name: String, genre: String, imageUrl100: String, imageUrl60: String, duration: String, contentRating: String, releaseDate: String, description: String, previewUrl: String, price: String ) {
        self.init()
        self.id = String(id)
        self.name = name
        self.genre = genre
        self.imageUrl100 = imageUrl100
        self.imageUrl60 = imageUrl60
        self.duration = duration
        self.contentRating = contentRating
        self.releaseDate = releaseDate
        self.longDescription = description
        self.previewUrl = previewUrl
        self.price = price
    }
    override class func primaryKey() -> String? {
        return "id"
    }
}
