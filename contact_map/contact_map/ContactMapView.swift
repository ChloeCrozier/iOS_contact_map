//
//  ContactMapView.swift
//  contact_map
//
//  Created by Chloe Crozier on 8/24/24.
//
import SwiftUI

struct ContactMapView: View {
    @EnvironmentObject var contactMapModel: ContactMapModel

    var body: some View {
        VStack {
            if contactMapModel.accessGranted {
                Text("Access granted! Contacts loaded.")
                    .font(.headline)
                    .padding()
                
                List(contactMapModel.contacts, id: \.identifier) { contact in
                    VStack(alignment: .leading) {
                        Text("\(contact.givenName) \(contact.familyName)")
                            .font(.headline)
                        ForEach(contact.phoneNumbers, id: \.label) { phoneNumber in
                            Text(phoneNumber.value.stringValue)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 5)
                }
            } else {
                Text("Access denied or not yet granted.")
                    .font(.headline)
                    .padding()
            }
        }
    }
}


#Preview {
    ContactMapView()
}
