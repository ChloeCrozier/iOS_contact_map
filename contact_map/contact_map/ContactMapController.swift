//
//  ContactMapController.swift
//  contact_map
//
//  Created by Chloe Crozier on 8/25/24.
//
import Contacts

class ContactMapController {
    let contactStore = CNContactStore()

    func requestContactAccess(completion: @escaping (Bool) -> Void) {
        print("Requesting contact access...")
        contactStore.requestAccess(for: .contacts) { granted, error in
            if granted {
                print("Access granted")
            } else {
                print("Access denied")
                if let error = error {
                    print("Error: \(error)")
                }
            }
            completion(granted)
        }
    }

    func fetchContacts() -> [CNContact] {
        print("Fetching contacts...")
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: keys)
        var contactsArray = [CNContact]()

        do {
            try contactStore.enumerateContacts(with: request) { contact, stopPointer in
                contactsArray.append(contact)
                print("Name: \(contact.givenName) \(contact.familyName)")
                print("Phone Numbers: \(contact.phoneNumbers.map { $0.value.stringValue })")
            }
        } catch let error {
            print("Failed to fetch contacts:", error)
        }

        return contactsArray
    }
}


