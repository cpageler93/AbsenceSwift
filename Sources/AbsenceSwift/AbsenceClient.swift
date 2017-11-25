//
//  AbsenceClient.swift
//  AbsenceSwift
//
//  Created by Christoph Pageler on 22.11.17.
//

import Foundation
import Quack
import SwiftyHawk
import HTTP


public extension Absence {
    
    public class Client: QuackClient {
        
        public enum Error: Swift.Error {
            case unknown
        }
        
        let hawkCredentials: Hawk.Credentials
        
        public init(id: String, key: String) {
            self.hawkCredentials = Hawk.Credentials(id: id, key: key, algoritm: .sha256)
            super.init(url: URL(string: "https://app.absence.io")!)
        }
        
        public func absences(options: Options? = nil) -> QuackResult<Result> {
            let body = bodyFrom(options: options)
            let headers = [
                HeaderKey("Content-Type"): "application/json",
            ]
            return respond(method: .post,
                           path: "/api/v2/absences",
                           body: body,
                           headers: headers,
                           model: Result.self,
                           requestModification:
            { request in
                // use request modification block to append Hawk Auth header
                return self.requestByAddingHawkAuth(request)
            })
        }
        
        public func absences(options: Options? = nil, completion: @escaping (QuackResult<Result>) -> ()) {
            let body = bodyFrom(options: options)
            let headers = [
                HeaderKey("Content-Type"): "application/json",
            ]
            
            respondAsync(method: .post,
                         path: "/api/v2/absences",
                         body: body,
                         headers: headers,
                         model: Result.self,
                         requestModification:
            { request in
                // use request modification block to append Hawk Auth header
                return self.requestByAddingHawkAuth(request)            
            }, completion: completion)
        }
        
        private func bodyFrom(options: Options?) -> [String: Any] {
            let options = options ?? Options.defaultOptions()
            return [
                "skip": options.skip,
                "limit": options.limit,
                "filter": options.filter?.body() ?? [:],
                "relations": [
                    "assignedToId",
                    "reasonId",
                    "approverId"
                ]
            ] as [String : Any]
        }
        
        private func requestByAddingHawkAuth(_ request: Request) -> Request {
            guard let headerResult = try? Hawk.Client.header(uri: super.url.appendingPathComponent(request.uri.description).absoluteString,
                                                             method: request.method.description,
                                                             credentials: hawkCredentials,
                                                             nonce: "FOOBAR")
            else {
                return request
            }
            
            request.headers[HeaderKey("Authorization")] = headerResult?.headerValue ?? ""
            return request
        }
        
    }

}
