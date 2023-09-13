//
//  Error.swift
//  JuiceMaker
//
//  Created by Swain Yun on 2023/09/12.
//

import Foundation

@frozen enum JuiceMakerError: Error, CustomDebugStringConvertible {
    case invalidSelection
    case outOfStock
    
    var debugDescription: String {
        switch self {
        case .invalidSelection: return "해당 품목 없음"
        case .outOfStock: return "재고 없음"
        }
    }
}
