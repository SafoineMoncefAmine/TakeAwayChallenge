import Foundation

enum Status: String {
    case closed = "closed"
    case orderAhead = "order ahead"
    case open = "open"
}

extension Status {
    static func > (lhs: Status, rhs: Status) -> Bool {
        switch (lhs, rhs) {
        case (.open, _): return true
        case (_, .open): return false
        case (.orderAhead, .closed): return true
        case (.closed, .orderAhead): return false
        default: return true
        }
    }
}
