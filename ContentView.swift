// MemoDemo-sample
//  ->MemoDemoApp.swift
//  ->ContentView.swift *
//    #This code
//  ->EditView.swift
//  ->PersistenceController.swift
//  ->MemoData.xcdatamodeld
//    #Add ENTITIES MemoData.Entities have content(String), id(String), and title(String).
//
//  ->Assets.xcassets

import SwiftUI
import CoreData

struct ContentView: View {
    @State var selectTab = 1　//default
    var body: some View {
        TabView(selection: $selectTab){
            HomeTabView().tabItem {
                Image(systemName: "note.text")
                Text("Memo")
            }.tag(1)
            DeveloperTabView().tabItem {
                Image(systemName: "person.text.rectangle")
                Text("Developer")
            }.tag(2)
        }
    }
}

struct HomeTabView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [])
    var memos: FetchedResults<MemoData>
    @State var input = ""
    @State var onsheet = false
    
    var body: some View {
        let IDList: [String] = setID()
        NavigationView{
            List{
                ForEach(memos){memo in
                    NavigationLink(destination:EditView(selfID:selfID(IDList:IDList, target: memo))){
                        if (memo.title?.isEmpty) == false {
                            Text("\(memo.title!)")
                        }
                    }
                }
                .onDelete(perform: delete)
                Button("New Memo",action:{onsheet=true})
                    .sheet(isPresented: $onsheet){
                        NewMemoView()
                    }
            }
            .navigationTitle("Memo")
            .scrollContentBackground(.hidden)
            .background(Color(red:176/255,green:224/255,blue:230/255))
        }
    }
    func delete(at offsets: IndexSet){
        offsets.forEach { index in
            let target = memos[index]
            viewContext.delete(target)
            do{
                try viewContext.save()
            }catch{
                fatalError("Fail to delete")
            }
            
        }
    }
    func setID()->[String]{
        //Input all id into array.
        var arr:[String]=[]
        for memos in memos {
            arr.append(memos.id!)
        }
        return arr
    }
    func selfID(IDList:[String],target: FetchedResults<MemoData>.Element)->String{
        //Search target id.
        var count=0
        var result = ""
        for memos in memos {
            if memos.id == target.id {
                result = IDList[count]
            }
            count+=1
        }
        return result
    }
    func addMemo(){
        let newMemo = MemoData(context: viewContext)
        newMemo.id = UUID().uuidString
        newMemo.title = input
        newMemo.content = ""
        do{
            try viewContext.save()
        }catch{
            fatalError("Fail to save...")
        }
        input = ""
    }
}

struct NewMemoView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [])
    var memos: FetchedResults<MemoData>
    @State var newtitle = ""
    @State var newcontent = ""
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack{
            VStack{
                TextField("TITLE",text: $newtitle)
                    .font(.title2)
                Divider()
            }
            .padding()
            
            TextEditor(text: $newcontent)
                .font(.title2)
                .overlay(RoundedRectangle(cornerRadius: 5.0).stroke(.gray,lineWidth: 1))
                .padding()
            Spacer()
            Button("Save",action: addMemo)
        }
        .padding(.vertical,30)
    }
    func addMemo(){
        let newMemo = MemoData(context: viewContext)
        newMemo.id = UUID().uuidString
        newMemo.title = newtitle
        newMemo.content = newcontent
        do{
            try viewContext.save()
        }catch{
            fatalError("Fail to save...")
        }
        dismiss()
    }
}

struct DeveloperTabView: View {
    var body: some View {
        
        Form{
            //prof
            Section{
                HStack{
                    Image(systemName: "person")
                    Text("Developer")
                    Spacer()
                    //Text()
                }
                HStack{
                    Image(systemName: "star")
                    Text("My Boom")
                    Spacer()
                    //Text()
                }
                HStack{
                    Image(systemName: "bubble")
                    Text("Comment")
                    Spacer()
                    //Text()
                }
            } header: {
                Text("Profile")
            }
            //sys
            Section{
                HStack{
                    Image(systemName: "app")
                    Text("App Name")
                    Spacer()
                    //Text()
                }
                HStack{
                    Image(systemName: "macpro.gen1")
                    Text("Version")
                    Spacer()
                    //Text()
                }
                HStack{
                    Image(systemName: "apple.terminal")
                    Text("Programming")
                    Spacer()
                    //Text()
                }
            } header: {
                Text("System")
            }
            //contact
            Section{
                HStack{
                    Image(systemName: "envelope")
                    Text("G-mail")
                    Spacer()
                    //Text()
                }
            } header: {
                Text("Contact")
            }
        }
        .padding(.vertical,40)
        .scrollContentBackground(.hidden)
        .background(Color(red:211/255,green:211/255,blue:211/255))
    }
}

#Preview {
    ContentView()
}

