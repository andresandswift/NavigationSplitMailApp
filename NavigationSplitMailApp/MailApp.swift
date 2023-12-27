//
//  NavigationSplitMailApp.swift
//  NavigationSplitMailApp
//
//  Created by Andres Portillo on 27.12.23.
//

import SwiftUI

@main
struct MailApp: App {
    @State private var viewModel = MailBoxListViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationSplitView {
                MailBoxListView(viewModel: viewModel)
            } content: {
                if let contentViewModel = viewModel.selectedViewModel {
                    MailboxView(viewModel: contentViewModel)
                }
            } detail: {
                if let detailViewModel = viewModel.selectedViewModel?.selectedViewModel {
                    MailView(viewModel: detailViewModel)
                }
            }
        }
    }
}
