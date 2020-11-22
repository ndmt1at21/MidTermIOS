//
//  Event.swift
//  MidTerm
//
//  Created by Minh Tri on 11/22/20.
//

import Foundation
import RealmSwift

class EventShow: Object {
    @objc dynamic var eventName = ""
    @objc dynamic var guests: [GuestInfo] = []
}
