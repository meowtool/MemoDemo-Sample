// MemoDemo-sample
//  ->MemoDemoApp.swift
//  ->ContentView.swift
//  ->EditView.swift *
//    #This code

//  ->PersistenceController.swift
//  ->MemoData.xcdatamodeld
//    #Add ENTITIES MemoData.Entities have content(String), id(String), and title(String).
//
//  ->Assets.xcassets

import SwiftUI
import CoreData

struct EditView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: []) //request data
    var memos: FetchedResults<MemoData>
    let selfID: String
    @State private var text = ""
    @State private var title = ""
    @FocusState var isInputActive: Bool
    var body: some View {
        NavigationView{
            TextEditor(text: $text)
                .focused($isInputActive)
                .font(.title2)
                .overlay(RoundedRectangle(cornerRadius: 5.0).stroke(.gray,lineWidth: 1))
                .padding()
                .scrollContentBackground(.hidden)
                .background(Color(red:255/255,green:255/255,blue:224/255))
                .lineSpacing(10.0)//行間
        }
        .navigationTitle("\(title)")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button("save",action: contentSave)
            }
        }
        .onAppear{
            reload()
        }
    }
    func contentSave(){
        for memos in memos {
            if memos.id == selfID {
                memos.content = text
                text = memos.content!
            }
        }
        do{
            try viewContext.save()
        }catch{
            fatalError("Fail to save...")
        }
        isInputActive = false
    }
    func reload(){
        for memos in memos {
            if memos.id == selfID {
                title = memos.title!
                text = memos.content!
                //id is selfID
            }
        }
    }
}
