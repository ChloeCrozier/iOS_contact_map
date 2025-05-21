//
//  ContactMapModel.swift
//  contact_map
//
//  Created by Chloe Crozier on 8/25/24.
//
import Foundation
import Contacts
import CoreLocation

struct ContactLocation: Identifiable {
    let id = UUID()
    let contact: CNContact
    let coordinate: CLLocationCoordinate2D
    let areaCode: String
}

class ContactMapModel: ObservableObject {
    @Published var contacts: [CNContact] = []
    @Published var contactLocations: [ContactLocation] = []
    @Published var accessGranted: Bool = false
    
    private let contactController: ContactMapController
    private let areaCodeService = AreaCodeService.shared

    init(contactController: ContactMapController) {
        self.contactController = contactController
    }

    func requestContactAccess() {
        contactController.requestContactAccess { granted in
            DispatchQueue.main.async {
                self.accessGranted = granted
                if granted {
                    self.fetchContacts()
                }
            }
        }
    }

    private func fetchContacts() {
        self.contacts = contactController.fetchContacts()
        processContactLocations()
        print("Contacts fetched: \(self.contacts.count)")
    }
    
    private func processContactLocations() {
        var locations: [ContactLocation] = []
        
        for contact in contacts {
            for phoneNumber in contact.phoneNumbers {
                if let areaCode = areaCodeService.extractAreaCode(from: phoneNumber.value.stringValue),
                   let coordinate = areaCodeService.getLocationForAreaCode(areaCode) {
                    let location = ContactLocation(
                        contact: contact,
                        coordinate: coordinate,
                        areaCode: areaCode
                    )
                    locations.append(location)
                }
            }
        }
        
        DispatchQueue.main.async {
            self.contactLocations = locations
        }
    }
}