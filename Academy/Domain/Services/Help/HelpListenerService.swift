import Combine

public final class HelpListenerService {
    private let helpRepository: HelpRepository
    
    init(helpRepository: HelpRepository) {
        self.helpRepository = helpRepository
    }
    
    public convenience init() {
        self.init(helpRepository: .shared)
    }
    
    public func listen(to type: HelpType) -> AnyPublisher<[Help], Never> {
        return helpRepository
            .readingPublisher
            .flatMap { data -> AnyPublisher<[Help], Never> in
                Just(data)
                    .decode(type: [Help].self, decoder: JSONDecoder.firebaseDecoder)
                    .replaceError(with: [])
                    .eraseToAnyPublisher()
            }
            .map { helps -> [Help] in
                if type == .all { return helps }
                return helps.filter { $0.type == type }
            }
            .map { helps -> [Help] in
                return helps.filter { $0.status != .done }
            }
            .map {
                $0.sorted { h1, h2 in h1.requestTimeInterval < h2.requestTimeInterval }
            }
            .eraseToAnyPublisher()
    }
}
