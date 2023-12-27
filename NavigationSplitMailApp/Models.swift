//
//  Models.swift
//  NavigationSplitMailApp
//
//  Created by Andres Portillo on 27.12.23.
//

import Foundation

struct Mail: Identifiable, Hashable {
    let id: UUID
    let subject: String
    let sender: String
    let content: String
    let date: Date

    init(id: UUID, subject: String, sender: String, content: String, date: Date) {
        self.id = id
        self.subject = subject
        self.sender = sender
        self.content = content
        self.date = date
    }
}

struct Mailbox: Hashable {
    let name: String
    let mails: [Mail]
}
