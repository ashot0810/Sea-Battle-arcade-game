//
//  GameResultsViewModel.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 11.10.23.
//

import Foundation

final class GameResultsViewModel {
    
    private var dataSourceModel: DataSourceForGameResultsForViewModel = DataSourceForGameResultsForViewModel()
    private(set) var providedData: [GameWinnerLoserResult] = [GameWinnerLoserResult]() {
        didSet {
            self.functionalityWhenDataGiven()
        }
    }
    
    var functionalityWhenDataGiven: () -> Void = {}
    
    func getDataFromDataSource() {
        let givenData = dataSourceModel.provideData()
        let sortedData = givenData.sorted { resultOne, resultTwo in
            resultOne.playerScores > resultTwo.playerScores
        }
        self.providedData = sortedData
    }
}
