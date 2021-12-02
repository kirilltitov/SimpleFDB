import FDB
import LGNLog

@main
struct Main {
    static func main() async throws {
        let fdb: AnyFDB = FDB()
        let logger = Logger.current

        try await fdb.withTransaction { transaction in
            let key = "test_key"

            let maybeValue = try await transaction.get(key: key)

            if let value = maybeValue {
                logger.info("Old value is '\(value.string)'")
            } else {
                logger.info("No previous value")
            }

            transaction.set(key: key, value: String.random().bytes)

            let maybeNewValue = try await transaction.get(key: key)

            guard let newValue = maybeNewValue else {
                throw E.e
            }

            logger.info("New value is '\(newValue.string)'")

            try await transaction.commit()
        }
    }
}

enum E: Error {
    case e
}

extension String {
    static func random(length: Int = 8) -> Self {
        let alphabet = "abcdefghijklmnopqrstuvwxyz"

        var result = ""

        for _ in 1...8 {
            result.append(alphabet.randomElement()!)
        }

        return result
    }

    var bytes: Bytes {
        Bytes(self.utf8)
    }
}

extension Array where Element == UInt8 {
    var string: String {
        String(bytes: self, encoding: .ascii)!
    }
}
