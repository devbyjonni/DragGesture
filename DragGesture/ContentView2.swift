//
//  ContentView2.swift
//  DragGesture
//
//  Created by Jonni Akesson on 2022-10-12.
//

import SwiftUI

struct ContentView2: View {
    
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.78
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            SignUpView()
            .offset(y: startingOffsetY)
            .offset(y: currentDragOffsetY)
            .offset(y: endingOffsetY)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        withAnimation(.spring()) {
                            currentDragOffsetY = value.translation.height
                        }
                    })
                    .onEnded({ value in
                        withAnimation(.spring()) {
                            if currentDragOffsetY < -150 {
                                endingOffsetY = -startingOffsetY
                            } else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                                endingOffsetY = 0
                            }
                            currentDragOffsetY = 0
                        }
                    })
            
            )
            VStack {
                Text("startingOffsetY \(startingOffsetY)")
                Text("dragOffsetY \(currentDragOffsetY)")
            }
                .padding(.top, 50)
        }
        .background(.green)
        .ignoresSafeArea()
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}

struct SignUpView: View {
    var body: some View {
        
        VStack(spacing: 20) {
            Image(systemName: "chevron.up")
                .padding(.top)
            
            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("Description...")
                .multilineTextAlignment(.center)
            
            Text("create a account")
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(.black)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(20)
        .padding(.top, 100)
    }
}
