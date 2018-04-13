//
//  Filter.swift
//  AbsenceSwift
//
//  Created by Christoph Pageler on 25.11.17.
//

import Foundation


public extension Absence {
    
    public class Filter {
        
        public enum Item {
            case start(DateItem)
            case end(DateItem)
            case assignedTo(UserItem)
            case firstname(String)
            case lastname(String)
            
            func bodyItem() -> (String, Any) {
                switch self {
                case .start(let dateItem):
                    let bi = dateItem.bodyItem()
                    return ("start", [bi.0: bi.1])
                case .end(let dateItem):
                    let bi = dateItem.bodyItem()
                    return ("end", [bi.0: bi.1])
                case .assignedTo(let userItem):
                    let ui = userItem.bodyItem()
                    return ("assignedTo:user._id", [ui.0: ui.1])
                case .firstname(let firstname):
                    return ("firstName", firstname)
                case .lastname(let lastname):
                    return ("lastName", lastname)
                }
            }
        }
        
        public enum DateItem {
            case lte(Date)
            case gte(Date)
            
            func bodyItem() -> (String, String) {
                switch self {
                case .lte(let date): return ("$lte", DateFormatter.string(from: date))
                case .gte(let date): return ("$gte", DateFormatter.string(from: date))
                }
            }
        }
        
        public enum UserItem {
            case email(String)
            case firstname(String)
            case lastname(String)
            
            func bodyItem() -> (String, String) {
                switch self {
                case .email(let email): return ("email", email)
                case .firstname(let firstname): return ("firstName", firstname)
                case .lastname(let lastname): return ("lastName", lastname)
                }
            }
        }
        
        public var items: [Item]
        
        public init(items: [Item]) {
            self.items = items
        }
        
        public func body() -> [String: Any] {
            var result = [String: Any]()
            for item in items {
                let bodyItem = item.bodyItem()
                result[bodyItem.0] = bodyItem.1
            }
            return result
        }
        
    }
    
}
