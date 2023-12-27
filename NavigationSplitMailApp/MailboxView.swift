//
//  MailboxView.swift
//  NavigationSplitMailApp
//
//  Created by Andres Portillo on 27.12.23.
//

import SwiftUI

protocol MailboxViewModelDelegate: AnyObject {
    func mailboxViewModel(_ viewModel: MailboxViewModel, didSelectMail mail: Mail)
}

@Observable
final class MailboxViewModel {
    static func == (lhs: MailboxViewModel, rhs: MailboxViewModel) -> Bool {
        lhs.mailbox == rhs.mailbox
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(mailbox)
    }

    private let mailbox: Mailbox
    var name: String { mailbox.name }
    var count: Int { mailbox.mails.count }
    var selectedMail: Mail? {
        didSet {
            if let selectedMail {
                delegate?.mailboxViewModel(self, didSelectMail: selectedMail)
            }
        }
    }

    weak var delegate: MailboxViewModelDelegate?

    init(mailbox: Mailbox) {
        self.mailbox = mailbox
    }

    var mails: [Mail] {
        mailbox.mails
    }

    func viewModel(for mail: Mail) -> MailViewModel {
        MailViewModel(mail: mail)
    }
}

struct MailboxView: View {
    @Bindable var viewModel: MailboxViewModel

    var body: some View {
        NavigationStack {
            List(selection: $viewModel.selectedMail) {
                ForEach(viewModel.mails) { mail in
                    NavigationLink(value: mail) {
                        MailListItemView(viewModel: viewModel.viewModel(for: mail))
                    }
                }
            }
            .navigationTitle(viewModel.name)
        }
    }
}
