//
//  Texts.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 05.08.2024.
//

import Foundation

enum Texts {

    enum ErrorMessage {
        static let general = "Что-то пошло не так.\nПопробуйте позже, должно получиться"
        static let noResults = "Ничего не найдено"
        static let failLoading = "Данные не загрузились"
        static let generalDescription = "Попробуйте позже, должно получиться"
    }

    enum LoadingMessage {
        static let inProgress = "Загрузка..."
    }

    enum OtherMessage {

    }

    enum ButtonTitles {
        static let search = "Найти"
    }

    enum NetworkLayerErrorMessages {
        static let success = "Успешный запрос"
        static let redirect = "Необходимо перенаправить запрос"
        static let authenticationError = "Клиент не авторизован"
        static let clientError = "Некорректный запрос к серверу"
        static let serverError = "Ошибка сервера"
        static let outdated = "URL адрес устарел"
        static let requestFailed = "Ошибка выполнения сетевого запроса"
        static let noData = "Ответ сервера не содержит данных"
        static let unableToDecode = "Ошибка декодирования ответа сервера"
        static let badResponse = "Некорректный ответ сервера"
        static let tooManyRequests = "Слишком много запросов"
        static let accessDenied = "Доступ запрещен"
    }
}
