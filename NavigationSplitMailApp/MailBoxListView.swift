//
//  MailBoxListView.swift
//  NavigationSplitMailApp
//
//  Created by Andres Portillo on 27.12.23.
//

import SwiftUI

@Observable
final class MailBoxListViewModel {
    var selectedViewModel: MailboxViewModel?

    var mailboxViewModels: [MailboxViewModel]

    init() {
        let mailboxes = [
            Mailbox(name: "Inbox", mails: MailFactory.makeMailArray(count: Int.random(in: 0...20))),
            Mailbox(name: "Sent", mails: MailFactory.makeMailArray(count: Int.random(in: 0...20))),
            Mailbox(name: "Trash", mails: MailFactory.makeMailArray(count: Int.random(in: 0...20))),
        ]

        mailboxViewModels = mailboxes.map { MailboxViewModel(mailbox: $0) }
        selectedViewModel = mailboxViewModels.first
    }
}

struct MailboxListItemView: View {
    private let viewModel: MailboxViewModel

    init(viewModel: MailboxViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack {
            Image(systemName: "tray.fill")
                .foregroundStyle(.primary)
            Text(viewModel.name)
            Spacer()
            Text("\(viewModel.count)")
                .foregroundColor(.secondary)
        }
    }
}

struct MailBoxListView: View {
    @Bindable private var viewModel: MailBoxListViewModel

    init(viewModel: MailBoxListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            List(selection: $viewModel.selectedViewModel) {
                ForEach(viewModel.mailboxViewModels, id: \.self) { viewModel in
                    NavigationLink(value: viewModel) {
                        MailboxListItemView(viewModel: viewModel)
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("Mailboxes")
        }
    }
}
