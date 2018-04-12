//
//  Client.swift
//  AbsenceSwift
//
//  Created by Christoph Pageler on 22.11.17.
//

import Foundation
import Quack
import SwiftyHawk


public extension Absence {
    
    public class Client: Quack.Client {
        
        public enum Error: Swift.Error {
            case unknown
        }
        
        private let hawkCredentials: Hawk.Credentials
        
        private let defaultHeader: [String: String] = [
            "Content-Type": "application/json"
        ]
        
        public init(id: String, key: String) {
            self.hawkCredentials = Hawk.Credentials(id: id, key: key, algoritm: .sha256)
            super.init(url: URL(string: "https://app.absence.io")!)
        }
        
        public func absences(options: Options? = nil) -> Quack.Result<Result<AbsencesResult>> {
            return respond(method: .post,
                           path: "/api/v2/absences",
                           body: absencesBodyFrom(options: options),
                           headers: defaultHeader,
                           model: Result<AbsencesResult>.self,
                           requestModification: defaultRequestModification())
        }
        
        public func absences(options: Options? = nil, completion: @escaping (Quack.Result<Result<AbsencesResult>>) -> ()) {
            respondAsync(method: .post,
                         path: "/api/v2/absences",
                         body: absencesBodyFrom(options: options),
                         headers: defaultHeader,
                         model: Result<AbsencesResult>.self,
                         requestModification: defaultRequestModification(),
                         completion: completion)
        }
        
        public func departments(options: Options? = nil) -> Quack.Result<Result<DepartmentsResult>> {
            return respond(method: .post,
                           path: "/api/v2/departments",
                           body: defaultBodyFrom(options: options),
                           headers: defaultHeader,
                           model: Result<DepartmentsResult>.self,
                           requestModification: defaultRequestModification())
        }
        
        public func departments(options: Options? = nil, completion: @escaping (Quack.Result<Result<DepartmentsResult>>) -> ()) {
            return respondAsync(method: .post,
                                path: "/api/v2/departments",
                                body: defaultBodyFrom(options: options),
                                headers: defaultHeader,
                                model: Result<DepartmentsResult>.self,
                                requestModification: defaultRequestModification(),
                                completion: completion)
        }
        
    }

}


fileprivate extension Absence.Client {
    
    private func absencesBodyFrom(options: Absence.Options?) -> Quack.Body {
        let options = options ?? Absence.Options.defaultOptions()
        return Quack.JSONBody([
            "skip": options.skip,
            "limit": options.limit,
            "filter": options.filter?.body() ?? [:],
            "relations": [
                "assignedToId",
                "reasonId",
                "approverId"
            ]
        ])
    }
    
    private func defaultBodyFrom(options: Absence.Options?) -> Quack.Body {
        let options = options ?? Absence.Options.defaultOptions()
        return Quack.JSONBody([
            "skip": options.skip,
            "limit": options.limit
        ])
    }
    
    private func defaultRequestModification() -> ((Quack.Request) -> (Quack.Request)) {
        return { request in
            var request = request
            request.encoding = .json
            return self.requestByAddingHawkAuth(request)
        }
    }
    
    private func requestByAddingHawkAuth(_ request: Quack.Request) -> Quack.Request {
        guard let headerResult = try? Hawk.Client.header(uri: super.url.appendingPathComponent(request.uri.description).absoluteString,
                                                         method: request.method.stringValue(),
                                                         credentials: hawkCredentials,
                                                         nonce: "FOOBAR")
            else {
                return request
        }
        var request = request
        request.headers["Authorization"] = headerResult?.headerValue ?? ""
        return request
    }
    
}
