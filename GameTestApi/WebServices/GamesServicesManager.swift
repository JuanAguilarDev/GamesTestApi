//
//  GamesServicesManager.swift
//  GamesTest
//
//  Created by Juan Aguilar on 04/08/25.
//

import Foundation
import Alamofire

final public class GamesServicesManager : GamesServicesManagerProtocol {
    
    // MARK: - Protocol Functions
    func fetchGames() async throws -> [GameModel] {
        // 1. Construir la configuración
        let config = RequestModelBuilder()
            .service(.GET_GAMES)
            .method(.GET)
            .build()
        
        // 2. Llamar al cliente de red
        let games: [GameModel] = try await AsyncClientRequest.shared
            .callService(requestModel: config, responseType: [GameModel].self)
        
        return games
    }
}
