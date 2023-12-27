//
//  MailBoxListView.swift
//  NavigationSplitMailApp
//
//  Created by Andres Portillo on 27.12.23.
//

import SwiftUI

protocol MailBoxListViewModelDelegate: AnyObject {
    func mailBoxListViewModel(_ viewModel: MailBoxListViewModel, didSelectMailbox mailbox: Mailbox)
}

@Observable
final class MailBoxListViewModel {
    var selectedMailbox: Mailbox? {
        didSet {
            if let selectedMailbox {
                delegate?.mailBoxListViewModel(self, didSelectMailbox: selectedMailbox)
            }
        }
    }

    var mailboxes = [
        Mailbox(name: "Inbox", mails: MailFactory.makeMailArray(count: Int.random(in: 0...20))),
        Mailbox(name: "Sent", mails: MailFactory.makeMailArray(count: Int.random(in: 0...20))),
        Mailbox(name: "Trash", mails: MailFactory.makeMailArray(count: Int.random(in: 0...20))),
    ]

    weak var delegate: MailBoxListViewModelDelegate?

    func viewModel(for mailbox: Mailbox) -> MailboxViewModel {
        MailboxViewModel(mailbox: mailbox)
    }

    func viewDidAppear() {
        selectedMailbox = mailboxes.first
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
            List(selection: $viewModel.selectedMailbox) {
                ForEach(viewModel.mailboxes, id: \.self) { mailbox in
                    NavigationLink(value: mailbox) {
                        MailboxListItemView(viewModel: viewModel.viewModel(for: mailbox))
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("Mailboxes")
        }
        .onAppear {
            viewModel.viewDidAppear()
        }
    }
}
