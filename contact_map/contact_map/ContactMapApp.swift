//
//  ContactMapApp.swift
//  contact_map
//
//  Created by Chloe Crozier on 8/24/24.
//
import SwiftUI

@main
struct ContactMapApp: App {
    let contactController = ContactMapController()
    
    @StateObject private var contactMapModel = ContactMapModel(contactController: ContactMapController())

    var body: some Scene {
        WindowGroup {
            ContactMapView()
                .environmentObject(contactMapModel) // Passing the model to the view
                .onAppear {
                    contactMapModel.requestContactAccess()
                }
        }
    }
}

