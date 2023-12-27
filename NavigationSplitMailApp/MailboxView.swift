//
//  MailboxView.swift
//  NavigationSplitMailApp
//
//  Created by Andres Portillo on 27.12.23.
//

import SwiftUI

@Observable
final class MailboxViewModel: Equatable, Hashable {
    static func == (lhs: MailboxViewModel, rhs: MailboxViewModel) -> Bool {
        lhs.mailbox == rhs.mailbox
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(mailbox)
    }

    private let mailbox: Mailbox
    var name: String { mailbox.name }
    var count: Int { mailbox.mails.count }
    var mailViewModels: [MailViewModel]
    var selectedViewModel: MailViewModel?

    init(mailbox: Mailbox) {
        self.mailbox = mailbox
        mailViewModels = mailbox.mails.map { MailViewModel(mail: $0) }
    }
}

struct MailboxView: View {
    @Bindable var viewModel: MailboxViewModel

    var body: some View {
        NavigationStack {
            List(selection: $viewModel.selectedViewModel) {
                ForEach(viewModel.mailViewModels) { viewModel in
                    NavigationLink(value: viewModel) {
                        MailListItemView(viewModel: viewModel)
                    }
                }
            }
            .navigationTitle(viewModel.name)
        }
    }
}
