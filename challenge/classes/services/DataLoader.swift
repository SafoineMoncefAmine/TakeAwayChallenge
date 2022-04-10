import Foundation

protocol DataLoaderProtocol {
    func load(fileName: String, completion: @escaping (Result<Data, Error>) -> Void)
}

class JSONDataLoader: DataLoaderProtocol {
    enum DataLoaderError: Swift.Error {
        case fileNotFound
    }
    func load(fileName: String, completion: @escaping (Result<Data, Error>) -> Void) {
        do {
            if let bundlePath = Bundle.main.path(forResource: fileName, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                completion(.success(jsonData))
            } else {
                throw DataLoaderError.fileNotFound
            }
        } catch {
            completion(.failure(DataLoaderError.fileNotFound))
        }
    }
}
