//
//  LabelView.swift
//  ImageLabeler2
//
//  Created by Christopher Yoon on 4/28/24.
//

import SwiftUI

struct LabelView: View {
    @State var data: LabelData
    var save: (LabelData) -> ()
    
    @State var isEdittingText : Bool = false
    @State var tempText: String = ""
    
    var body: some View {
        ZStack {
            Group {
                if isEdittingText {
                    HStack {
                        TextField("", text: $tempText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading)
                        Button {
                            isEdittingText = false
                            data.labelText = tempText
                            save(data)
                        } label: {
                            Text("Done")
                        }
                        .buttonStyle(BorderedButtonStyle())
                        .disabled(tempText.isEmpty)
                    }
                    .frame(height: 40)
                    .frame(width: 150)
                    .background(.gray)
                } else {
                    Text(data.labelText)
                        .onLongPressGesture {
                            tempText = data.labelText
                            isEdittingText = true
                        }
                        .foregroundColor(.white)
                        .padding(5)
                        .background(.black)
                        .cornerRadius(15)
                }
            }
            .position(CGPoint(x: data.positionX, y: data.positionY))
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.data.positionX = value.location.x
                        self.data.positionY = value.location.y
                        save(data)
                    }
            )
        }
    }
}

#Preview {
    LabelView(data: LabelData(), save: { _ in })
}
