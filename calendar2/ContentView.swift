//
//  ContentView.swift
//  calendar2
//
//  Created by Eva Skarabot on 8/15/23.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var showAlert = false
    @StateObject private var vm = viewModel()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 250
    var body: some View {
        VStack {
            Text("Here is a timer that you can use to time how long you want to study or take a break for.")
                .font(.title)
                .padding()
            
            Text("To enter focus mode, click the button below, go to Accessibility in Settings and then scroll down to Guided Access")
                .font(.title3)
                .padding()
            
            
            //lockdown
            Button("Enable Kiosk Mode") {
                showAlert = true
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Enter Focus Mode?"),
                    message: Text("Focus mode will restrict the device to this app."),
                    primaryButton: .default(Text("Enable"), action: enableKioskMode),
                    secondaryButton: .cancel()
                )
            }
            
            
            
            
            Text("\(vm.time)")
                .font(.system(size: 70, weight: .medium, design: .rounded))
                  .padding()
                  .frame(width:width)
                  .background(.thinMaterial)
                  .cornerRadius(20)
                .alert("Timer done!", isPresented: $vm.showingAlert){
                        
                    Button("Continue", role: .cancel){
                    //code
                }
                    
                }
            Slider(value: $vm.minutes, in: 1...30, step:1)
                .padding()
                .frame(width: width)
                .disabled(vm.isActive)
                .animation(.easeInOut, value:vm.minutes)
            HStack(spacing:50){
                Button("Start"){
                    vm.start(minutes: vm.minutes)
                }.disabled(vm.isActive)
                
                Button("Reset", action:vm.reset)
                    .tint(.red)
                
                
            }.frame(width: width)
        }
        .onReceive(timer){ _ in
            vm.updateTime()
            
        }
        
    }
    private func enableKioskMode() {
        guard let url = URL(string: "app-settings:root=ACCESSIBILITY") else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
