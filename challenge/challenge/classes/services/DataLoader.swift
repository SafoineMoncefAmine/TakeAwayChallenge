import Foundation

protocol DataLoaderProtocol {
    func load(fileName: String, completion: (Result<Data, Error>) -> Void)
}

class JSONDataLoader: DataLoaderProtocol {
    func load(fileName: String, completion: (Result<Data, Error>) -> Void) {
        do {
            if let bundlePath = Bundle.main.path(forResource: fileName, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                completion(.success(jsonData))
            }
        } catch {
            completion(.failure(error))
        }
    }
}
