//
//  ResponseCollectionSerializable.swift
//  OneHTPlus
//
//  Created by lisheng on 17/9/2.
//  Copyright © 2017年 LS Software. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol ResponseCollectionSerializable {
    
    static func collection(responseJSON: JSON) -> [Self]?
}

extension ResponseCollectionSerializable where Self: ResponseObjectSerializable {
    
    static func collection(responseJSON: JSON) -> [Self]? {
        
        var collection = [Self]()
        
        if responseJSON != JSON.null && !responseJSON.isEmpty {
            
            // JSON Loop
            for (_, subJSON): (String, JSON) in responseJSON {
                if let item = Self(responseJSON: subJSON) {
                    collection.append(item)
                }
            }
        }
        return collection
    }
}
