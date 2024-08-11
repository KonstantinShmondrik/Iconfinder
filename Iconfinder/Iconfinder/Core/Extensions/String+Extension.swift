//
//  String+Extension.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 10.08.2024.
//

import Foundation
import CommonCrypto

extension String {

    func drop(prefix: String) -> String {
        guard hasPrefix(prefix) else { return self }
        return String(dropFirst(prefix.count))
    }

    func drop(suffix: String) -> String {
        guard hasSuffix(suffix) else { return self }
        return String(dropLast(suffix.count))
    }

    func sha256() -> String {
        let inputData = Data(self.utf8)
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        inputData.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(inputData.count), &hash)
        }
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }

    func removeTrailingSpace() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
}
