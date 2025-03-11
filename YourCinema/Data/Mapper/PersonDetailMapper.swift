//
//  PersonDetailMapper.swift
//  YourCinema
//
//  Created by Владислав Соколов on 27.02.2025.
//

import Foundation

final class PersonDetailMapper {
    static func map(person: Actor) -> PersonEntity {
        return PersonEntity(
            movieId: person.movies.map { $0.id ?? 0 },
            name: person.name ?? "Неизвестно",
            photo: person.photo ?? "",
            birthday: formatBirthday(person.birthday),
            birthPlace: (person.birthPlace ?? []).map { $0.value ?? "" },
            proffesion: (person.profession ?? []).map { $0.value ?? "" }
        )
    }

    private static func formatBirthday(_ birthday: String?) -> String {
        guard let birthday else { return "Неизвестно" }

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC")

        if let date = inputFormatter.date(from: birthday) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "d MMMM, yyyy"
            outputFormatter.locale = Locale(identifier: "ru_RU")
            return outputFormatter.string(from: date)
        }

        return "Неизвестно"
    }

}


