//
//  AbsenceEntry.swift
//  AbsenceSwift
//
//  Created by Christoph Pageler on 22.11.17.
//

import Foundation
import Quack
import SwiftyJSON


public class AbsenceEntry: QuackModel {
    
    public let id: String
//    public let start: Date
//    public let end: Date
//    public let created: Date
//    public let modified: Date
    public let assignedTo: AbsenceUser?
    public let approver: AbsenceUser?
    
    public required init?(json: JSON) {
        guard
            let id = json["_id"].string
        else {
            return nil
        }
        
        self.id = id
        self.assignedTo = AbsenceUser(json: json["assignedTo"])
        self.approver = AbsenceUser(json: json["approver"])
    }
    
}
