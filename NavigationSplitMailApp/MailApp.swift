//
//  NavigationSplitMailApp.swift
//  NavigationSplitMailApp
//
//  Created by Andres Portillo on 27.12.23.
//

import SwiftUI

@main
struct MailApp: App {
    @State private var viewModel = MailAppViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationSplitView(columnVisibility: $viewModel.columnVisibility) {
                MailBoxListView(viewModel: viewModel.mailBoxListViewModel)
            } content: {
                if let contentViewModel = viewModel.mailBoxViewModel {
                    MailboxView(viewModel: contentViewModel)
                }
            } detail: {
                if let detailViewModel = viewModel.mailViewModel {
                    MailView(viewModel: detailViewModel)
                }
            }
        }
    }
}
