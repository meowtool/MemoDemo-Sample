// MemoDemo-sample
//  ->MemoDemoApp.swift *
//    #This code

//  ->ContentView.swift
//  ->EditView.swift
//  ->PersistenceController.swift
//  ->MemoData.xcdatamodeld
//    #Add ENTITIES MemoData.Entities have content(String), id(String), and title(String).
//
//  ->Assets.xcassets

import SwiftUI

@main
struct MemoDemoApp: App {
    let persistenceController = PersistenceController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,persistenceController.container.viewContext)
        }
    }
}
