//
//  AsyncClientRequestModel.swift
//  GamesTest
//
//  Created by Juan Aguilar on 04/08/25.
//

import Foundation
import Alamofire


struct AsyncClientRequestModel {
    var service: Service = .GET_GAMES
    var httpMethod: HttpMethod = .GET
    var bodyParameters: Parameters?
    var headers: HTTPHeaders?
    var key1: String?
    var key2: String?
}

struct RequestModelBuilder {
    private let model: AsyncClientRequestModel

    init() { self.model = AsyncClientRequestModel() }
    private init(model: AsyncClientRequestModel) { self.model = model }

    func service(_ service: Service) -> Self {
        var m = model; m.service = service; return Self(model: m)
    }
    func method(_ method: HttpMethod) -> Self {
        var m = model; m.httpMethod = method; return Self(model: m)
    }
    func body(_ params: Parameters?) -> Self {
        var m = model; m.bodyParameters = params; return Self(model: m)
    }
    func headers(_ headers: HTTPHeaders?) -> Self {
        var m = model; m.headers = headers; return Self(model: m)
    }
    func key1(_ k: String) -> Self {
        var m = model; m.key1 = k; return Self(model: m)
    }
    func key2(_ k: String) -> Self {
        var m = model; m.key2 = k; return Self(model: m)
    }
    func build() -> AsyncClientRequestModel { model }
}
