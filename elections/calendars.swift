//
//  calendars.swift
//  elections
//
//  Created by Dominic Ruiz-Esparza on 10/15/18.
//  Copyright © 2018 Dominic Ruiz-Esparza. All rights reserved.
//

import Foundation
import EventKit

struct elecEvent {
    var title: String
    var startDate: String
    var endDate: String
    var isAllDay: Bool
    var notes: String
}

var FirstEvent = elecEvent(title: "Municipal Elections Day", startDate: "2019-11-05", endDate: "2019-11-05", isAllDay: true, notes: "In odd-numbered years, North Carolina has municipal elections, which are a big deal! Your vote has more impact in municipal elections than state or federal because turnout is lower. City and county officials are counting on you! electionCal")
var SecondEvent = elecEvent(title: "Election Day", startDate: "2018-11-09", endDate: "2018-11-09", isAllDay: true, notes: "This is a cool day. Okay. electionCal")
var ThirdEvent = elecEvent(title: "Recall Day", startDate: "2018-11-10", endDate: "2018-11-10", isAllDay: true, notes: "electionCal")



var NorthCarolina = [FirstEvent]
