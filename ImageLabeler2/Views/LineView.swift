//
//  LineView.swift
//  ImageLabeler2
//
//  Created by Christopher Yoon on 4/29/24.
//

import SwiftUI

struct LineView: View {
    @State var data : LineData
    var save: (LineData) -> ()
    
    @State var isSelected : Bool = false
    @State var endpoint1 : CGPoint = CGPoint(x: 50, y: 50)
    @State var endpoint2 : CGPoint = CGPoint(x: 100, y: 50)
    
    var body: some View {
        ZStack {
            Path { path in
                path.move(to: CGPoint(x: data.endpoint1X, y: data.endpoint1Y))
                path.addLine(to: CGPoint(x: data.endpoint2X, y: data.endpoint2Y))
            }
            .stroke(Color.black, lineWidth: 5)
            .onTapGesture {
                isSelected.toggle()
                save(data)
            }
            Rectangle()
                .frame(width: 10, height: 10)
                .position(CGPoint(x: data.endpoint1X, y: data.endpoint1Y))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.data.endpoint1X = Double(value.location.x)
                            self.data.endpoint1Y = Double(value.location.y)
                            save(data)
                        }
                )
                .foregroundStyle(isSelected ? .black : .clear)
            Rectangle()
                .frame(width: 10, height: 10)
                .position(CGPoint(x: data.endpoint2X, y: data.endpoint2Y))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.data.endpoint2X = Double(value.location.x)
                            self.data.endpoint2Y = Double(value.location.y)
                            save(data)
                        }
                )
                .foregroundStyle(isSelected ? .black : .clear)
        }
    }
}

#Preview {
    LineView(data: LineData(), save: { _ in })
}
