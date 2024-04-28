//
//  DataList.swift
//  ImageLabeler2
//
//  Created by Christopher Yoon on 4/28/24.
//

import SwiftUI
import SwiftData

struct DataListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var dataModels: [DataModel]
    
    var body: some View {
        List {
            ForEach(dataModels) { model in
                NavigationLink {
                    VStack {
                        Text(model.id.description)
                        Text(model.dateCreated, style: .date)
                        ImageBackground(dataModel: model)
                    }
                    
                } label: {
                    HStack {
//                        ImageBackground(dataModel: model)
                        VStack {
                            Text(model.name)
                            Text(model.dateCreated, style: .date)
                        }
                        Spacer()
                    }
                }
            }
            .onDelete(perform: deleteItems)
        }
        .navigationTitle("PictureList")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    add(DataModel())
                }, label: {
                    Label("New Image", systemImage: "plus")
                })
            }
        }
    }
    private func add(_ dataModel: DataModel) {
        withAnimation {
            modelContext.insert(dataModel)
        }
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(dataModels[index])
            }
        }
    }
    
    private func delete(_ dataModel: DataModel) {
        withAnimation {
            modelContext.delete(dataModel)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: DataModel.self, configurations: config)
    
    return NavigationStack {
        DataListView()
    }
    .modelContainer(container)
}
