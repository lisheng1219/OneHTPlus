//
//  AccessToken.swift
//  OneHTPlus
//
//  Created by lisheng on 17/9/2.
//  Copyright © 2017年 LS Software. All rights reserved.
//

import Foundation
import SwiftyJSON

final class AccessToken: ResponseObjectSerializable {
    
    var access_token: String?
    var expires_date: Double?
    var refresh_token: String?
    
    init?(responseJSON: JSON) {
        
        if responseJSON.isEmpty {
            return nil
        }
        
        self.access_token = responseJSON["access_token"].string
        self.expires_date = responseJSON["expires_date"].double
        self.refresh_token = responseJSON["refresh_token"].string
    }
    
}
