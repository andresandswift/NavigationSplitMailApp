//
//  Factory.swift
//  NavigationSplitMailApp
//
//  Created by Andres Portillo on 27.12.23.
//

import Fakery
import Foundation

enum MailFactory {
    static func makeMailArray(count: Int) -> [Mail] {
        (0 ..< count).map { _ in makeMail() }
            .sorted { $0.date > $1.date }
    }

    static func makeMail() -> Mail {
        let faker = Faker()
        return Mail(
            id: UUID(),
            subject: faker.lorem.sentence(),
            sender: faker.name.name(),
            content: faker.lorem.sentences(amount: Int.random(in: 10..<50)),
            date: faker.date.backward(days: Int.random(in: 0 ..< 10))
        )
    }
}
