//
//  OfdConnector.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 24.09.2024.
//

import Foundation

class OfdConnector {
    // Создаем синглтон
    static let shared = OfdConnector()

    // Приватный инициализатор, чтобы предотвратить создание других экземпляров
    private init() {}

    // Метод для отправки данных на сервер
    func sendToServer(message: Data, serverIP: String, serverPort: UInt16) throws -> Data {
        let socket = try createSocket()
        print("Socket создан: \(socket)")

        // Устанавливаем тайм-аут на отправку и получение данных
        try setSocketTimeouts(socket: socket)
        
        try connectToServer(socket: socket, serverIP: serverIP, serverPort: serverPort)
        print("Подключение к серверу \(serverIP):\(serverPort) выполнено")

        try sendMessage(socket: socket, message: message)
        print("Сообщение отправлено на сервер")

        let response = try receiveMessage(socket: socket)
        print("Ответ от сервера получен: \(response as NSData)")

        close(socket)
        print("Сокет закрыт")

        return response
    }

    // Создание сокета
    private func createSocket() throws -> Int32 {
        let socketFD = socket(AF_INET, SOCK_STREAM, 0)
        if socketFD == -1 {
            throw NSError(domain: "SocketCreation", code: 1, userInfo: [NSLocalizedDescriptionKey: "Не удалось создать сокет"])
        }
        return socketFD
    }

    // Подключение к серверу
    private func connectToServer(socket: Int32, serverIP: String, serverPort: UInt16) throws {
        var serverAddress = sockaddr_in()
        serverAddress.sin_family = sa_family_t(AF_INET)
        serverAddress.sin_port = serverPort.bigEndian
        serverAddress.sin_addr.s_addr = inet_addr(serverIP)

        let connectionResult = withUnsafePointer(to: &serverAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                connect(socket, $0, socklen_t(MemoryLayout<sockaddr_in>.size))
            }
        }
        if connectionResult == -1 {
            throw NSError(domain: "ConnectionError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Не удалось подключиться к серверу"])
        }
    }
    
    // Установка общего тайм-аута на отправку и получение данных (7 секунд)
    private func setSocketTimeouts(socket: Int32) throws {
        var timeout = timeval(tv_sec: 7, tv_usec: 0) // Тайм-аут 7 секунд
        let receiveTimeoutResult = setsockopt(socket, SOL_SOCKET, SO_RCVTIMEO, &timeout, socklen_t(MemoryLayout<timeval>.size))
        let sendTimeoutResult = setsockopt(socket, SOL_SOCKET, SO_SNDTIMEO, &timeout, socklen_t(MemoryLayout<timeval>.size))

        if receiveTimeoutResult < 0 || sendTimeoutResult < 0 {
            throw NSError(domain: "SocketTimeout", code: 5, userInfo: [NSLocalizedDescriptionKey: "Не удалось установить тайм-аут на отправку и получение данных"])
        }
    }

    // Отправка сообщения на сервер
    private func sendMessage(socket: Int32, message: Data) throws {
        let sendResult = message.withUnsafeBytes {
            send(socket, $0.baseAddress!, message.count, 0)
        }
        if sendResult == -1 {
            throw NSError(domain: "SendError", code: 3, userInfo: [NSLocalizedDescriptionKey: "Не удалось отправить сообщение"])
        }
    }

    // Получение ответа от сервера
    private func receiveMessage(socket: Int32) throws -> Data {
        // Читаем заголовок (первые 18 байт)
        var headerBuffer = [UInt8](repeating: 0, count: 18)
        let headerBytes = recv(socket, &headerBuffer, headerBuffer.count, 0)
        
        if headerBytes < 18 {
            throw NSError(domain: "ReceiveError", code: 4, userInfo: [NSLocalizedDescriptionKey: "Не удалось получить полный заголовок сообщения"])
        }
        
        // Десериализуем заголовок
        let headerData = Data(headerBuffer)
        let header = try MessageHeader.fromData(headerData)
        print("Прочитан заголовок:", header)
        
        // Извлекаем полный размер сообщения из заголовка
        let totalSize = Int(header.size)
        let payloadSize = totalSize - 18
        
        // Создаем буфер для всей полезной нагрузки
        var messageData = Data(headerData) // Начинаем с заголовка
        var payloadBuffer = [UInt8](repeating: 0, count: payloadSize)
        var totalBytesRead = 0
        
        // Читаем оставшуюся полезную нагрузку
        while totalBytesRead < payloadSize {
            let remainingBytes = payloadSize - totalBytesRead
            let bytesRead = recv(socket, &payloadBuffer[totalBytesRead], remainingBytes, 0)
            
            if bytesRead <= 0 {
                throw NSError(domain: "ReceiveError", code: 5, userInfo: [NSLocalizedDescriptionKey: "Ошибка при чтении полезной нагрузки. Данных не достаточно."])
            }
            
            totalBytesRead += bytesRead
        }
        
        // Добавляем прочитанную полезную нагрузку к сообщению
        messageData.append(payloadBuffer, count: totalBytesRead)
        
        return messageData
    }

}
