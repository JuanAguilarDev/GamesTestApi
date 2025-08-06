//
//  GamesServicesManagerProtocol.swift
//  GamesTest
//
//  Created by Juan Aguilar on 04/08/25.
//

import Foundation

protocol GamesServicesManagerProtocol: AnyObject, Sendable {
    func fetchGames() async throws -> [GameModel]
}
