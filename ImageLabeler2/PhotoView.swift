//
//  PhotoView.swift
//  ImageLabeler2
//
//  Created by Christopher Yoon on 4/28/24.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    @State var wallpaper: PhotosPickerItem?
    
    var body: some View {
        PhotosPicker(selection: $wallpaper) {
            Label("Select a photo", systemImage: "photo")
        }
    }
}


struct ImageBackground: View {
    @State var image: Data?
    @Bindable var dataModel: DataModel
    @State var selectedImage: PhotosPickerItem?
    var body: some View {
        ZStack {
            VStack {
                if let image = self.image,
                   let image = UIImage(data: image) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .foregroundStyle(.gray)
                }
                Spacer()
                HStack {
                    PhotosPicker(selection: $selectedImage) {
                        Label("Select a photo",
                              systemImage: "photo")
                    }
                    .buttonStyle(BorderedButtonStyle())
                    .onChange(of: selectedImage) { oldValue, newValue in
                        Task {
                            if let image = try? await newValue?.loadTransferable(type: Data.self) {
                                self.image = image
                                dataModel.imageData = self.image
                            }
                        }
                    }
                    .padding(.leading)
                    Spacer()
                }
                .onAppear(perform: {
                    if let image = dataModel.imageData {
                        self.image = image
                    }
                })
            }
        }
    }
}

//#Preview {
//    ImageBackground()
//}
