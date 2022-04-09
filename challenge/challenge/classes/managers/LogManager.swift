import Foundation

let log = LogManager()

class LogManager {

    enum Level: String {
        case debug = "💬 Debug"
        case info = "ℹ️ Info"
        case warning = "⚠️ Warning"
        case error = "‼️ Error"
    }

    public func debug(_ message: String? = nil,
                      fileName: String = #file,
                      functionName: String = #function,
                      lineNumber: Int = #line) {
        display(message, at: .debug, fileName: fileName, functionName: functionName, lineNumber: lineNumber)
    }

    public func info(_ message: String? = nil,
                     fileName: String = #file,
                     functionName: String = #function,
                     lineNumber: Int = #line) {
        display(message, at: .info, fileName: fileName, functionName: functionName, lineNumber: lineNumber)
    }

    public func warning(_ message: String? = nil,
                        fileName: String = #file,
                        functionName: String = #function,
                        lineNumber: Int = #line) {
        display(message, at: .warning, fileName: fileName, functionName: functionName, lineNumber: lineNumber)
    }

    public func error(_ message: String? = nil,
                      fileName: String = #file,
                      functionName: String = #function,
                      lineNumber: Int = #line) {
        display(message, at: .error, fileName: fileName, functionName: functionName, lineNumber: lineNumber)
    }

    private func display(_ message: String?, at level: Level, fileName: String, functionName: String, lineNumber: Int) {
        #if DEBUG
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        if let message = message {
            print("\(dateFormatter.string(from: Date())) [\(level.rawValue)] " +
                  "[\(URL(fileURLWithPath: fileName).lastPathComponent):\(lineNumber)] \(functionName) > \(message)")
        } else {
            print("\(dateFormatter.string(from: Date())) " +
                  "[\(level)] [\(URL(fileURLWithPath: fileName).lastPathComponent):\(lineNumber)] \(functionName) >")
        }
        #endif
    }
}
