//
//  SavedItemsViewModel.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 14.10.23.
//

import Foundation
import UIKit

final class SavedItemsViewModel {
    
    private(set) var providedDataForMaps: [[String]] = [[String]]()
    private(set) var providedDataForShipsRotatedLeft: [[String]] = [[String]]()
    private(set) var providedDataForShipsRotatedRight: [[String]] = [[String]]()
    private(set) var providedDataAboutWaterMarks: [[Int:Int]] = [[Int:Int]]()
    private(set) var providedMapImageData: [Data] = [Data]()
    private(set) var providedShipsCountData: [Int] = [Int]()
    
    private var dataModel: DataSourceForSavedItemsViewController = DataSourceForSavedItemsViewController()
    
    var functionalityWhenDataProvided: () -> Void = {}

    func getData() {
        let (map,shipsLeft,shipsRight,waterMarks, image, shipsCount) = self.dataModel.provideData()
        self.providedDataForMaps = map
        self.providedDataForShipsRotatedLeft = shipsLeft
        self.providedDataForShipsRotatedRight = shipsRight
        self.providedDataAboutWaterMarks = waterMarks
        self.providedMapImageData = image
        self.providedShipsCountData = shipsCount
    }
    
    func provideDataModelsForIndexPath(indexPath: IndexPath) -> ViewModelForMapAndShips {
        return ViewModelForMapAndShips(mapDataModel: MapDataModel(dataModelForMap: self.providedDataForMaps[indexPath.item], waterMarksCounting: self.providedDataAboutWaterMarks[indexPath.item]), shipsDataMode: DataModelForShipsSection(dataForShipsLeft: self.providedDataForShipsRotatedLeft[indexPath.item], dataForShipsRight: self.providedDataForShipsRotatedRight[indexPath.item]),shipsCount: self.providedShipsCountData[indexPath.item])
    }
}
