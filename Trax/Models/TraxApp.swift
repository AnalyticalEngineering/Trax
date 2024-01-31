//
//  TraxApp.swift
//  Trax
//
//  Created by J. DeWeese on 1/30/24.
//

import SwiftUI

@main
struct TraxApp: App {
    var body: some Scene {
        WindowGroup {
            TransactionListView()
        }
        .modelContainer(for:  Transaction.self)
    }
        init() {
            print(URL.applicationSupportDirectory.path(percentEncoded: false))
        }
    }
