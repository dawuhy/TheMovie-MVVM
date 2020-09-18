//
//  GuestSessionIDResult.swift
//  TheMovie-MVVM
//
//  Created by Huy on 9/18/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation

class GuestSessionIDResult: Decodable {
    let success: Bool
    let guestSessionID: String
    let expiresAt: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case guestSessionID = "guest_session_id"
        case expiresAt = "expires_at"
    }
}
