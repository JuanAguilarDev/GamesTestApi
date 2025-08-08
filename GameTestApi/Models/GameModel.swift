//
//  GameModel.swift
//  GamesTest
//
//  Created by Juan Aguilar on 05/08/25.
//

import Foundation
import SwiftData

@Model
final class GameModel: Decodable, Sendable, Hashable {
    var id: Int
    var title: String
    var thumbnail: String
    var shortDescription: String
    var gameUrl: String
    var genre: String
    var platform: String
    var publisher: String?
    var developer: String?
    var releaseDate: String
    var freeToGameProfileUrl: String?
    
    init(id: Int, title: String, thumbnail: String, shortDescription: String, gameUrl: String, genre: String, platform: String, publisher: String? = nil, developer: String? = nil, releaseDate: String, freeToGameProfileUrl: String? = nil) {
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
        self.shortDescription = shortDescription
        self.gameUrl = gameUrl
        self.genre = genre
        self.platform = platform
        self.publisher = publisher
        self.developer = developer
        self.releaseDate = releaseDate
        self.freeToGameProfileUrl = freeToGameProfileUrl
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let title = try container.decode(String.self, forKey: .title)
        let thumbnail = try container.decode(String.self, forKey: .thumbnail)
        let shortDescription = try container.decode(String.self, forKey: .shortDescription)
        let gameUrl = try container.decode(String.self, forKey: .gameUrl)
        let genre = try container.decode(String.self, forKey: .genre)
        let platform = try container.decode(String.self, forKey: .platform)
        let publisher = try container.decodeIfPresent(String.self, forKey: .publisher)
        let developer = try container.decodeIfPresent(String.self, forKey: .developer)
        let releaseDate = try container.decode(String.self, forKey: .releaseDate)
        let freeToGameProfileUrl = try container.decodeIfPresent(String.self, forKey: .freeToGameProfileUrl)
        self.init(
            id: id, title: title, thumbnail: thumbnail,
            shortDescription: shortDescription, gameUrl: gameUrl,
            genre: genre, platform: platform,
            publisher: publisher, developer: developer,
            releaseDate: releaseDate,
            freeToGameProfileUrl: freeToGameProfileUrl
        )
    }
    
    static func == (lhs: GameModel, rhs: GameModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher){ hasher.combine(id) }
}

extension GameModel {
    enum CodingKeys: String, CodingKey {
        case id, title, thumbnail, genre, platform
        case shortDescription = "short_description"
        case gameUrl = "game_url"
        case releaseDate = "release_date"
        case publisher, developer
        case freeToGameProfileUrl = "freetogame_profile_url"
    }
    
    // MARK: - Dummy Data For Testing Models
    static let dummyGame = GameModel(
        id: 582,
        title: "Tarisland",
        thumbnail: "https://www.freetogame.com/g/582/thumbnail.jpg",
        shortDescription: "A cross‑platform MMORPG developed by Level Infinite and Published by Tencent.",
        gameUrl: "https://www.freetogame.com/open/tarisland",
        genre: "MMORPG",
        platform: "PC (Windows)",
        publisher: "Tencent",
        developer: "Level Infinite",
        releaseDate: "2024-06-22",
        freeToGameProfileUrl: "https://www.freetogame.com/tarisland"
    )
}

