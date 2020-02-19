import Foundation

protocol IndexStore {

    func getIndex(name: String) -> String
}

class InMemoryIndexStore : IndexStore {

    func getIndex(name: String) -> String {
        return "foo"
    }

}
