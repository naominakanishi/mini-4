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
            .decode(type: [Help].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .map { helps -> [Help] in
                if type == .all { return helps }
                return helps.filter { $0.type == type }
            }
            .map { $0.sorted { h1, h2 in
                h1.requestTimeInterval < h2.requestTimeInterval
            }}
            .eraseToAnyPublisher()
    }
}
