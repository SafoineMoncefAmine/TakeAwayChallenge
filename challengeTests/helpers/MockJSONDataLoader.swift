import Foundation
@testable import challenge

class MockJSONDataLoader: DataLoaderProtocol {
    var loadInvocation: [(Result<Data, Error>) -> Void] = []
    func load(fileName: String, completion: @escaping (Result<Data, Error>) -> Void) {
        loadInvocation.append(completion)
    }
}
