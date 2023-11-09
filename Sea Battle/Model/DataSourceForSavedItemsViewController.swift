//
//  DataSourceForSavedItemsViewController.swift
//  Sea Battle
//
//  Created by Ashot Hovhannisyan on 15.10.23.
//

import Foundation


struct DataSourceForSavedItemsViewController {
    
    private var providedDataForMaps: [[String]] = [[String]]()
    private var providedDataForShipsRotatedLeft: [[String]] = [[String]]()
    private var providedDataForShipsRotatedRight: [[String]] = [[String]]()
    private var providedDataAboutWaterMarks: [[Int:Int]] = [[Int:Int]]()
    private var mapImageData: [Data] = [Data]()
    private var addedShipsCount: [Int] = [Int]()
    
    init(){}
    
    mutating func getData() {
        self.providedDataForMaps = DataSavingManager.loadSavedMaps()
        self.providedDataForShipsRotatedLeft = DataSavingManager.loadSavedShipsLeftRotated()
        self.providedDataForShipsRotatedRight = DataSavingManager.loadSavedShipsRightRotated()
        self.providedDataAboutWaterMarks = DataSavingManager.loadWaterMarksData()
        self.mapImageData = DataSavingManager.loadMapsImage()
        self.addedShipsCount = DataSavingManager.loadShipsCountData()
    }
    
    mutating func provideData() -> ([[String]],[[String]],[[String]],[[Int:Int]],[Data],[Int]) {
        self.getData()
        return (self.providedDataForMaps,self.providedDataForShipsRotatedLeft,self.providedDataForShipsRotatedRight,self.providedDataAboutWaterMarks,self.mapImageData,self.addedShipsCount)
    }
    
}
