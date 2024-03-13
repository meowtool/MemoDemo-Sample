// MemoDemo-sample
//  ->MemoDemoApp.swift
//  ->ContentView.swift
//  ->EditView.swift
//  ->PersistenceController.swift *
//    #This code

//  ->MemoData.xcdatamodeld
//    #Add ENTITIES MemoData.Entities have content(String), id(String), and title(String).
//
//  ->Assets.xcassets

import Foundation
import CoreData

struct PersistenceController {
    let container: NSPersistentContainer
    init() {
        container = NSPersistentContainer(name: "MemoData")
        container.loadPersistentStores(completionHandler: {(StoreDescription,error) in
            if let error = error as NSError?{
                fatalError("Unresolved error \(error)")
            }
        })
    }
}
