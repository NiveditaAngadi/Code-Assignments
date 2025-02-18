//
//  SettingsScreen.swift
//  SwiftUIinUIKit
//
//  Created by Nivedita Angadi on 10/02/25.
//

import SwiftUI

struct SettingsScreen: View {
    @State var isOn = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Toggle(isOn: $isOn, label: {
                        Text("Is Subscriber")
                    })
                    Toggle(isOn: $isOn, label: {
                        Text("Is Subscriber")
                    })
                    Toggle(isOn: $isOn, label: {
                        Text("Is Subscriber")
                    })
                    
                    Spacer()
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsScreen()
}
