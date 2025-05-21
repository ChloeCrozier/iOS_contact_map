//
//  ContactMapView.swift
//  contact_map
//
//  Created by Chloe Crozier on 8/24/24.
//
import SwiftUI
import MapKit

struct ContactMapView: View {
    @EnvironmentObject var contactMapModel: ContactMapModel
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
    )

    var body: some View {
        VStack {
            if contactMapModel.accessGranted {
                Map(coordinateRegion: $region, annotationItems: contactMapModel.contactLocations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(.blue)
                                .font(.title)
                            Text(location.contact.givenName)
                                .font(.caption)
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(4)
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
                
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
                .frame(height: 200)
            } else {
                VStack {
                    Text("Access denied or not yet granted.")
                        .font(.headline)
                        .padding()
                    Button("Request Access") {
                        contactMapModel.requestContactAccess()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
        }
    }
}

#Preview {
    ContactMapView()
        .environmentObject(ContactMapModel(contactController: ContactMapController()))
}
