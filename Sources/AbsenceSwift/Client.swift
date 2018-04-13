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
        
    }

}

// MARK: - Absences

public extension Absence.Client {
    
    public typealias AbsenceResult = Absence.Result<Absence.AbsencesResult>
    public typealias QuackAbsenceResult = Quack.Result<AbsenceResult>
    
    public func absences(options: Absence.Options? = nil) -> QuackAbsenceResult {
        return respond(method: .post,
                       path: "/api/v2/absences",
                       body: absencesBodyFrom(options: options),
                       headers: defaultHeader,
                       model: AbsenceResult.self,
                       requestModification: defaultRequestModification())
    }
    
    public func absences(options: Absence.Options? = nil, completion: @escaping (QuackAbsenceResult) -> ()) {
        respondAsync(method: .post,
                     path: "/api/v2/absences",
                     body: absencesBodyFrom(options: options),
                     headers: defaultHeader,
                     model: AbsenceResult.self,
                     requestModification: defaultRequestModification(),
                     completion: completion)
    }
    
}

// MARK: - Departments

public extension Absence.Client {
    
    public typealias DepartmentResult = Absence.Result<Absence.DepartmentsResult>
    public typealias QuackDepartmentResult = Quack.Result<DepartmentResult>
    
    public func departments(options: Absence.Options? = nil) -> QuackDepartmentResult {
        return respond(method: .post,
                       path: "/api/v2/departments",
                       body: bodyFrom(options: options),
                       headers: defaultHeader,
                       model: DepartmentResult.self,
                       requestModification: defaultRequestModification())
    }
    
    public func departments(options: Absence.Options? = nil, completion: @escaping (QuackDepartmentResult) -> ()) {
        return respondAsync(method: .post,
                            path: "/api/v2/departments",
                            body: bodyFrom(options: options),
                            headers: defaultHeader,
                            model: DepartmentResult.self,
                            requestModification: defaultRequestModification(),
                            completion: completion)
    }
    
}

// MARK: - Users

public extension Absence.Client {
    
    public typealias UserResult = Absence.Result<Absence.UsersResult>
    public typealias QuackUserResult = Quack.Result<UserResult>
    
    public func users(options: Absence.Options? = nil) -> QuackUserResult {
        return respond(method: .post,
                       path: "/api/v2/users",
                       body: bodyFrom(options: options),
                       headers: defaultHeader,
                       model: UserResult.self,
                       requestModification: defaultRequestModification())
    }
    
    public func users(options: Absence.Options? = nil, completion: @escaping (QuackUserResult) -> ()) {
        return respondAsync(method: .post,
                            path: "/api/v2/users",
                            body: bodyFrom(options: options),
                            headers: defaultHeader,
                            model: UserResult.self,
                            requestModification: defaultRequestModification(),
                            completion: completion)
    }
    
}

// MARK: - Private Helper

fileprivate extension Absence.Client {
    
    private func absencesBodyFrom(options: Absence.Options?) -> Quack.Body {
        return bodyFrom(options: options, byAdding: [
            "relations": [
                "assignedToId",
                "reasonId",
                "approverId"
            ]
        ])
    }
    
    private func bodyFrom(options: Absence.Options?, byAdding dict: [String: Any]? = nil) -> Quack.Body {
        let options = options ?? Absence.Options.defaultOptions()
        
        var defaultOptions: [String: Any] = [
            "skip": options.skip,
            "limit": options.limit,
            "filter": options.filter?.body() ?? [:]
        ]
        for (key, value) in dict ?? [:] {
            defaultOptions[key] = value
        }
        
        return Quack.JSONBody(defaultOptions)
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
