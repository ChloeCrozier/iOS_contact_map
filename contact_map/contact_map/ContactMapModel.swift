//
//  ContactMapModel.swift
//  contact_map
//
//  Created by Chloe Crozier on 8/25/24.
//
import Foundation
import Contacts

class ContactMapModel: ObservableObject {
    @Published var contacts: [CNContact] = []
    @Published var accessGranted: Bool = false
    
    private let contactController: ContactMapController

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
        print("Contacts fetched: \(self.contacts.count)")
    }
}
