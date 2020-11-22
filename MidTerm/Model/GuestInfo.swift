//
//  GuestInfo.swift
//  MidTerm
//
//  Created by Minh Tri on 11/20/20.
//

import Foundation
import RealmSwift

class GuestInfo: Object {
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var nGuest = 0
    @objc dynamic var tableID = ""
    @objc dynamic var sectionID = ""
}
