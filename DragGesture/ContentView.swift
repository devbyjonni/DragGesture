//
//  ContentView.swift
//  DragGesture
//
//  Created by Jonni Akesson on 2022-10-12.
//

import SwiftUI

struct ContentView: View {
    
    @State var offsetAnimated: CGSize = .zero
    @State var offset: CGSize = .zero
    @State var scale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            VStack {
                Text("Offset: \(offset.width)")
                Text("Scale: \(scale)")
                Spacer()
            }
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 200, height: 300)
                .offset(offsetAnimated)
                .scaleEffect(getScaleAmount())
                .rotationEffect(Angle(degrees: getRotationAmount()))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            scale = getScaleAmount()
                            offset = value.translation
                            withAnimation(.spring()) {
                                offsetAnimated = value.translation
                            }
                        }
                        .onEnded{ value in
                            offset = .zero
                            scale = 1.0
                            withAnimation(.spring()) {
                                offsetAnimated = .zero
                            }
                        }
                )
        }
    }
    
    private func getScaleAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offsetAnimated.width)
        let percentage = currentAmount / max
        
        return 1.0 - min(percentage, 0.5) * 0.5
    }
    
    private func getRotationAmount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = offsetAnimated.width
        let percentage = currentAmount / max
        let percentageAsDouble = Double(percentage)
        let maxAngle = 10.0
        
        return percentageAsDouble * maxAngle
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
