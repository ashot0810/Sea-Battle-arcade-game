//
//  DataSourceForGameResultsViewModel.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 11.10.23.
//

import Foundation
import SimpleKeychain

protocol DecodeManager {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

extension JSONDecoder: DecodeManager {}

struct DataRecieverFromKeyChain<T> where T: Decodable {
    
    private var decoder: DecodeManager
    
    init(decoder: DecodeManager) {
        self.decoder = decoder
    }
    
    func getData() -> [T] {
        guard let data = try? SimpleKeychain().data(forKey: "gameResult") else { return [T]()
        }
        guard let decodedData = try? self.decoder.decode([T].self, from: data) else {return [T]()
        }
        return decodedData
    }
}

struct DataSourceForGameResultsForViewModel {
    private var data = DataRecieverFromKeyChain<GameWinnerLoserResult>(decoder: JSONDecoder()).getData()
    func provideData() -> [GameWinnerLoserResult] {
        return self.data
    }
}

