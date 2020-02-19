import AsyncHTTPClient
import Foundation
import Logging

fileprivate extension String {

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}

public class EtcdClient {

    private let logger = Logger(label: "EtcdClient")
    private let client: HTTPClient

    init() {
        self.client = HTTPClient(eventLoopGroupProvider: .createNew)
    }
    
    deinit {
        try? client.syncShutdown()
    }

    public func put(key: String, value: String) {
        var request = try? HTTPClient.Request(url: "http://localhost:2379/v3/kv/put", method: .POST)
//        request.headers.add(name: "User-Agent", value: "EtcdClient-Swift-1.0.0-SNAPSHOT")
//        request.body = HTTPClient.Body.string("foo")
//        cat
    }
    
}
