//
//  GenericEnums.swift
//  GamesTest
//
//  Created by Juan Aguilar on 04/08/25.
//

import Alamofire

enum Service {
    case GET_GAMES
    
    var path: String {
        switch self {
        case .GET_GAMES:
            return "/games"
        }
    }
}

enum HttpMethod: String {
    case GET, POST, PUT, DELETE
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .GET:
            return .get
        case .POST:
            return .post
        case .PUT:
            return .put
        case .DELETE:
            return .delete
        }
    }
}
