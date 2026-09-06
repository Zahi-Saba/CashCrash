//
//  ContentView.swift
//  CashCrash
//
//  Created by Zahi Saba on 2/9/2026.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = CashCrashViewModel()
    
    var body: some View {
        DashboardView(viewModel: viewModel)
           }
}

#Preview {
    ContentView()
}
