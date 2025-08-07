//
//  GameModel.swift
//  GamesTest
//
//  Created by Juan Aguilar on 05/08/25.
//

import Foundation

struct GameModel: Decodable, Sendable, Hashable {
    let id: Int
    let title: String
    let thumbnail: String
    let shortDescription: String
    let gameUrl: String
    let genre: String
    let platform: String
    let publisher: String?
    let developer: String?
    let releaseDate: String
    let freeToGameProfileUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, thumbnail, genre, platform
        case shortDescription = "short_description"
        case gameUrl = "game_url"
        case releaseDate = "release_date"
        case publisher, developer
        case freeToGameProfileUrl = "freetogame_profile_url"
    }
}

extension GameModel {
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

