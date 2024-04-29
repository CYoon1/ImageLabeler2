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
                    TextField("Save Name", text: $model.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text(model.dateCreated, style: .date)
                    ImageBackground(dataModel: model)
                }
                Spacer()
                VStack {
                    Button("New Line") {
                        addLine()
                    }
                    .buttonStyle(BorderedButtonStyle())
                    Button("New Label") {
                        addLabel()
                    }
                    .buttonStyle(BorderedButtonStyle())
                }
            }
            ForEach(model.labels) { label in
                LabelView(data: label, save: updateLabel)
            }
            ForEach(model.lines) { line in
                LineView(data: line, save: updateLine)
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
    private func addLine() {
        let newLine = LineData()
        model.lines.append(newLine)
    }
    private func updateLine(_ data: LineData) {
        guard let index = model.lines.firstIndex(where: {data.id == $0.id}) else { return }
        model.lines[index] = data
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
