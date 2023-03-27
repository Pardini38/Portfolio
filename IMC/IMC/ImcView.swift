//
//  ContentView.swift
//  IMC
//
//  Created by user on 28/10/22.
//

import SwiftUI

struct ImcView: View {
    var body: some View {
        VStack {
            Image(systemName: "checkmark.seal.fill")
                .imageScale(.large)
                .foregroundColor(.mint)
            Text("Welcome to Nutrip")
                .font(.title3)
                .foregroundColor(.mint)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ImcView()
    }
}
