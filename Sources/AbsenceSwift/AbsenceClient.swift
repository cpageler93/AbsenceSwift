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

public class AbsenceClient: QuackClient {
    
    public enum Error: Swift.Error {
        case unknown
    }
    
    let hawkCredentials: Hawk.Credentials
    
    public init(id: String, key: String) {
        self.hawkCredentials = Hawk.Credentials(id: id, key: key, algoritm: .sha256)
        super.init(url: URL(string: "https://app.absence.io")!)
    }
    
    public func absences(options: AbsencesOptions? = nil) -> QuackResult<AbsencesResult> {
        let options = options ?? AbsencesOptions.defaultOptions()
        let body = [
            "skip": options.skip,
            "limit": options.limit,
            "filter": options.filter?.body() ?? [:],
            "relations": [
                "assignedToId",
                "reasonId",
                "approverId"
            ]
        ] as [String : Any]
        
        let uri = super.url.appendingPathComponent("/api/v2/absences").absoluteString
        guard let headerResult = try? Hawk.Client.header(uri: uri,
                                                         method: "POST",
                                                         credentials: hawkCredentials,
                                                         nonce: "FOOBAR")
        else {
            return QuackResult.failure(Error.unknown)
        }
        
        let headers = [
            HeaderKey("Content-Type"): "application/json",
            HeaderKey("Authorization"): headerResult?.headerValue ?? "",
        ]
        
        return respond(method: .post,
                       path: "/api/v2/absences",
                       body: body,
                       headers: headers,
                       model: AbsencesResult.self)
    }
    
}
