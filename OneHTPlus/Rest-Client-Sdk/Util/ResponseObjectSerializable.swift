//
//  ResponseObjectSerializable.swift
//  OneHTPlus
//
//  Created by lisheng on 17/9/2.
//  Copyright © 2017年 LS Software. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol ResponseObjectSerializable {
    
    init?(responseJSON: JSON)
}
