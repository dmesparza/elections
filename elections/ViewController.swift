//
//  ViewController.swift
//  elections
//
//  Created by Dominic Ruiz-Esparza on 10/15/18.
//  Copyright © 2018 Dominic Ruiz-Esparza. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var picker: UIPickerView!
    
    let pickerData = ["Alabama","Florida","Georgia","North Carolina", "South Carolina", "Tennessee",]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        picker.delegate = self
        picker.dataSource = self
    }
    
    

    func createEvents() {
        
        for electionEvent in NorthCarolina {
            
            // Get access to the calendar.
            let store: EKEventStore = EKEventStore()
            store.requestAccess(to: .event) { (granted, error) in
                
                if (granted) && (error == nil) {
                    print("create granted \(granted)")
                    print("create store access error \(error.debugDescription)")
                    
                    // Define EKevent and save it.
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let sDate: Date? = dateFormatter.date(from: electionEvent.startDate)
                    let event: EKEvent = EKEvent(eventStore: store)
                    
                    event.title = electionEvent.title
                    event.startDate = sDate
                    event.endDate = sDate
                    event.isAllDay = electionEvent.isAllDay
                    event.notes = electionEvent.notes
                    event.calendar = store.defaultCalendarForNewEvents
                    
                    
                    do {
                        try store.save(event, span: .thisEvent)
                        print("Event created.")
                    } catch let error as NSError {
                        print("Event creation error is \(error).")
                    }
                }
            }
        }
    }
    
    func deleteEvents() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let sDate: Date? = dateFormatter.date(from: (NorthCarolina.first?.startDate)!)
        
        let store: EKEventStore = EKEventStore()
        
        store.requestAccess(to: .event) { (granted, error) in
            
            if (granted) && (error == nil) {
                print("delete granted \(granted)")
                print("delete store access error \(error.debugDescription)")
                
                // Get the appropriate calendar.
                let calendar = Calendar.current
                
                // Create the start date components
                var oneDayAgoComponents = DateComponents()
                oneDayAgoComponents.day = -1
                var oneDayAgo = calendar.date(byAdding: oneDayAgoComponents, to: Date(), wrappingComponents: false)
                
                // Create the end date components.
                var oneYearFromNowComponents = DateComponents()
                oneYearFromNowComponents.year = 1
                var oneYearFromNow = calendar.date(byAdding: oneYearFromNowComponents, to: Date(), wrappingComponents: false)
                
                // Create the predicate from the event store's instance method.
                var predicate: NSPredicate? = nil
                if let anAgo = oneDayAgo, let aNow = oneYearFromNow {
                    predicate = store.predicateForEvents(withStart: sDate!, end: aNow, calendars: nil)
                }
                
                // Fetch all events that match the predicate.
                var events = EKEventStore().events(matching: predicate!)
                if let aPredicate = predicate {
                    events = store.events(matching: aPredicate)
                }
                for item in events {
                    if item.notes?.range(of: "electionCal") != nil {
                        do {
                            try store.remove(item, span: .thisEvent)
                            try store.commit()
                            print("Event \(String(describing: item.eventIdentifier)) deleted.")
                        } catch let error as NSError {
                            print("Event deletion error is \(error).")
                        }
                    }
                }
            }
        }
    }
    

    
    
    @IBAction func AddElections(_ sender: Any) {
        deleteEvents()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.createEvents()
        }
    }
    
}
