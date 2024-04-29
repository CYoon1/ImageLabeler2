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
                    DataEditView(model: model)
                } label: {
                    HStack {
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
struct DataEditView: View {
    @Bindable var model: DataModel
    
    var body: some View {
        ZStack {
            HStack {
                VStack {
                    Text(model.id.description)
                    TextField("Save Name", text: $model.name)
                    Text(model.dateCreated, style: .date)
                    ImageBackground(dataModel: model)
                }
                Spacer()
                VStack {
                    Text("New Line")
                    Button("New Label") {
                        let newLabel = LabelData()
                        self.model.labels.append(newLabel)
                    }
                }
            }
            ForEach(model.labels) { label in
                LabelView(data: label, save: updateLabel)
            }
        }
    }
    private func addLabel() {
        let newLabel = LabelData()
        model.labels.append(newLabel)
    }
    private func updateLabel(_ data: LabelData) {
        guard let index = model.labels.firstIndex(where: {data.id == $0.id}) else { return }
        model.labels[index] = data
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
