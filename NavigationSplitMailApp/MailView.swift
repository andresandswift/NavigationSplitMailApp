//
//  MailDetailView.swift
//  NavigationSplitMailApp
//
//  Created by Andres Portillo on 27.12.23.
//

import SwiftUI

@Observable
final class MailViewModel: Equatable, Hashable, Identifiable {
    static func == (lhs: MailViewModel, rhs: MailViewModel) -> Bool {
        lhs.mail == rhs.mail
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(mail)
    }

    var id: UUID { mail.id }

    private let mail: Mail

    init(mail: Mail) {
        self.mail = mail
    }

    var subject: String { mail.subject }
    var sender: String { mail.sender }
    var content: String { mail.content }
    var date: Date { mail.date }
}

struct MailListItemView: View {
    var viewModel: MailViewModel

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text(viewModel.sender)
                        .font(.headline)
                        .lineLimit(1)

                    Spacer()
                    Text(viewModel.date, style: .date)
                        .font(.subheadline)
                }
                Text(viewModel.subject)
                    .font(.subheadline)
                Spacer()
            }

            Text(viewModel.content)
                .font(.footnote)
                .lineLimit(2)

            Spacer()

        }.padding()
    }
}

struct MailView: View {
    var viewModel: MailViewModel

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text(viewModel.sender)
                            .font(.title3)

                        Spacer()
                        Text(viewModel.date, style: .date)
                            .font(.subheadline)
                    }

                    Text(viewModel.subject)
                        .font(.subheadline)
                }

                Spacer()

                Text(viewModel.content)
                    .font(.body)

                Spacer()
            }
        }
        .padding()
    }
}
