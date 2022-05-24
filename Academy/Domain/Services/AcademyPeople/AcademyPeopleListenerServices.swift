//
//  AcademyPeopleListenerServices.swift
//  Academy
//
//  Created by HANNA P C FERREIRA on 22/05/22.
//

import Foundation
import Combine

public class AcademyPeopleListenerService {
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository){
        self.userRepository = userRepository
    }
    
    public convenience init() {
        self.init(userRepository: .shared)
    }
    
    public var academyPeople: AnyPublisher<[AcademyUser], Never> {
        userRepository.allUsersPublisher.flatMap { data in
            Just (data)
                .decode(type: [AcademyUser].self, decoder: JSONDecoder.firebaseDecoder)
                .breakpointOnError()
                .replaceError(with: [])
        }
        .replaceError(with: [])
        .eraseToAnyPublisher()
    }
 
    
    public func people(withRole role: Role) ->  AnyPublisher<[AcademyUser], Never>  {
        academyPeople
            .map { users in
                if role == .all { return users }
                return users.filter { $0.role == role}
            }
            .eraseToAnyPublisher()
    }
}

