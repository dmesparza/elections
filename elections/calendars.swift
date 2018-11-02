//
//  calendars.swift
//  elections
//
//  Created by Dominic Ruiz-Esparza on 10/15/18.
//  Copyright © 2018 Dominic Ruiz-Esparza. All rights reserved.
//

import Foundation
import EventKit


struct testEvent {
    var title: String
    var startDate: String
    var endDate: String
    var isAllDay: Bool
    var notes: String
}

var FirstEvent = testEvent(title: "Registration Day", startDate: "2018-10-31", endDate: "2018-10-31", isAllDay: true, notes: "electionCal")
var SecondEvent = testEvent(title: "Election Day", startDate: "2018-11-02", endDate: "2018-11-02", isAllDay: true, notes: "electionCal")
var ThirdEvent = testEvent(title: "Recall Day", startDate: "2018-10-31", endDate: "2018-10-31", isAllDay: true, notes: "electionCal")

var NorthCarolina = [FirstEvent, SecondEvent]
