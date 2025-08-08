//
//  AsyncClientRequest.swift
//  GamesTest
//
//  Created by Juan Aguilar on 04/08/25.
//

import Foundation
import Alamofire

actor AsyncClientRequest {
    static let successCode: Int = 200
    static let failureCode: Int = 400
    
    static let shared = AsyncClientRequest()
    private let session: Session
    init(session: Session = .default) { self.session = session }
    
    var params: Parameters = [:]
    let baseURL = URL(string: "https://www.freetogame.com/api")!
    
    func callService<T: Decodable>(
        requestModel: AsyncClientRequestModel,
        responseType: T.Type
    ) async throws -> T {
        
        var url: String = getUrl(requestModel: requestModel)
        let method: HTTPMethod = requestModel.httpMethod.method
        let headers = requestModel.headers
        
        if let key = requestModel.key1, url.contains(":key1"){
            url = url.replacingOccurrences(of: ":key1", with: key)
        }
        
        if let key = requestModel.key2, url.contains(":key2"){
            url = url.replacingOccurrences(of: ":key1", with: key)
        }
        
        let parameters = requestModel.bodyParameters
        let encoding: ParameterEncoding = parameters != nil ? JSONEncoding.default : URLEncoding.default
        
        
        let dataTask = session.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers
        )
            .validate()
            .serializingDecodable(T.self, automaticallyCancelling: true)
        
        return try await dataTask.value
    }
    
    func getUrl(requestModel: AsyncClientRequestModel) -> String {
        return baseURL.appendingPathComponent(requestModel.service.path).absoluteString
    }
}
