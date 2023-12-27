//
//  MailAppViewModel.swift
//  NavigationSplitMailApp
//
//  Created by Andres Portillo on 10.01.24.
//

import SwiftUI

@Observable
final class MailAppViewModel: MailBoxListViewModelDelegate, MailboxViewModelDelegate {
    let mailBoxListViewModel: MailBoxListViewModel
    var mailBoxViewModel: MailboxViewModel?
    var mailViewModel: MailViewModel?
    var columnVisibility: NavigationSplitViewVisibility = .all

    init() {
        self.mailBoxListViewModel = MailBoxListViewModel()
        mailBoxListViewModel.delegate = self
    }

    // MARK: - MailBoxListViewModelDelegate

    func mailBoxListViewModel(_ viewModel: MailBoxListViewModel, didSelectMailbox mailbox: Mailbox) {
        mailBoxViewModel = MailboxViewModel(mailbox: mailbox)
        mailBoxViewModel?.delegate = self
    }

    // MARK: - MailboxViewModelDelegate

    func mailboxViewModel(_ viewModel: MailboxViewModel, didSelectMail mail: Mail) {
        mailViewModel = MailViewModel(mail: mail)
    }
}
