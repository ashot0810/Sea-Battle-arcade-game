//
//  UnitTestsForMapDataModel.swift
//  Sea Battle Tests
//
//  Created by Ashot Hovhannisyan on 18.10.23.
//

import XCTest
@testable import Sea_Battle

final class UnitTestsForMapDataModel: XCTestCase {

    var mapDataModel: MapDataModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mapDataModel = MapDataModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mapDataModel = nil
    }

    func testExampleForProvidingMethods() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        //Given
        let dataModelForMap: [String] = {
            let dict:[Int:String] = [
                11:"A",
                22:"B",
                33:"C",
                44:"D",
                55:"E",
                66:"F",
                77:"G",
                88:"H",
                99:"I",
                110:"J"
            ]
            var data:[String] = [""]
            for i in 1...10 {
                data.append("\(i)")
            }
            for i in 11...120 {
                if dict[i] != nil {
                    data.append(dict[i]!)
                } else {
                    data.append("mappCelll")
                }
            }
            return data
        }()
        
        let waterMarksCountByIndex: [Int:Int] = {
            var data: [Int:Int] = [Int:Int]()
            for i in 0...120 {
                data[i] = 0
            }
            return data
        }()
        //When
        
        //Then
        XCTAssertEqual(mapDataModel.provideData(), dataModelForMap)
        XCTAssertEqual(mapDataModel.provideWaterMarkCount(for: 0), 0)
        XCTAssertEqual(mapDataModel.provideWaterMarkCount(for: 10), 0)
        XCTAssertEqual(mapDataModel.provideWaterMarkCount(for: 120), 0)
        XCTAssertEqual(mapDataModel.provideWaterMarkCount(for: -1), 0)
        XCTAssertEqual(mapDataModel.provideWaterMarkCount(for: 121), 0)
        XCTAssertEqual(mapDataModel.provide(), waterMarksCountByIndex)
        XCTAssertEqual(mapDataModel.provideDataAboutWaterMarks(), waterMarksCountByIndex)
        XCTAssertTrue(!mapDataModel.provideIndexPathsForHighlighting(indexPath: IndexPath(item: 0, section: 0), shipIndentificator: .fourCellShip).isEmpty)
        XCTAssertTrue(!mapDataModel.provideIndexPathsForHighlighting(indexPath: IndexPath(item: 50, section: 0), shipIndentificator: .fourCellShipRotated).isEmpty)
        XCTAssertTrue(!mapDataModel.provideIndexPathsForHighlighting(indexPath: IndexPath(item: 50, section: 0), shipIndentificator: .oneCellShip).isEmpty)
        XCTAssertTrue(!mapDataModel.provideIndexPathsForHighlighting(indexPath: IndexPath(item: 50, section: 0), shipIndentificator: .oneCellShipRotated).isEmpty)
        XCTAssertTrue(!mapDataModel.provideIndexPathsForHighlighting(indexPath: IndexPath(item: 50, section: 0), shipIndentificator: .twoCellShip).isEmpty)
        XCTAssertTrue(!mapDataModel.provideIndexPathsForHighlighting(indexPath: IndexPath(item: 50, section: 0), shipIndentificator: .twoCellShipRotated).isEmpty)
        XCTAssertTrue(!mapDataModel.provideIndexPathsForHighlighting(indexPath: IndexPath(item: 50, section: 0), shipIndentificator: .threeCellShip).isEmpty)
        XCTAssertTrue(!mapDataModel.provideIndexPathsForHighlighting(indexPath: IndexPath(item: 50, section: 0), shipIndentificator: .threeCellShipRotated).isEmpty)
        //Given
        XCTAssertEqual(mapDataModel.provideData(), dataModelForMap)
        //When
        let randomData = mapDataModel.provideDataFromRandom()
        //Then
        XCTAssertEqual(mapDataModel.provideData(), randomData)
        XCTAssertEqual(mapDataModel.getData(on: 10), randomData[10])
        XCTAssertEqual(mapDataModel.getData(on: -1), "")
        XCTAssertEqual(mapDataModel.getData(on: 121), "")

    }
    
    func testExampleForMethodWaterMarkCountIncreaser() {
        //Given
        
        //When
        mapDataModel.increaseWaterMarkCount(for: 9)
        //Then
        XCTAssertEqual(mapDataModel.provideWaterMarkCount(for: 9),1)
        
        //Given
        
        //When
        mapDataModel.increaseWaterMarkCount(for: -1)
        //Then
        XCTAssertEqual(mapDataModel.provideWaterMarkCount(for: -1),0)
        
        //Given
        
        //When
        mapDataModel.increaseWaterMarkCount(for: 121)
        //Then
        XCTAssertEqual(mapDataModel.provideWaterMarkCount(for: 121),0)
    }
    
    func testExampleForMethodWaterMarkCountDecreaser() {
        //Given
        
        //When
        mapDataModel.decreaseWaterMarkCount(for: 9)
        //Then
        XCTAssertEqual(mapDataModel.provideWaterMarkCount(for: 9),0)
        
        //Given
        
        //When
        mapDataModel.decreaseWaterMarkCount(for: -1)
        //Then
        XCTAssertEqual(mapDataModel.provideWaterMarkCount(for: -1),0)
        
        //Given
        
        //When
        mapDataModel.decreaseWaterMarkCount(for: 121)
        //Then
        XCTAssertEqual(mapDataModel.provideWaterMarkCount(for: 121),0)
    }
    
    func testExampleForMethodMapDataByIndexMutator() {
        //Given
        let data = mapDataModel.provideData()
        //When
        mapDataModel.changeData(in: 121, with: "AA")
        //Then
        XCTAssertEqual(mapDataModel.provideData(),data)
        
        //Given

        //When
        mapDataModel.changeData(in: 50, with: "AA")
        //Then
        XCTAssertEqual(mapDataModel.getData(on: 50),"AA")
        
        //Given

        //When
        mapDataModel.changeData(in: 9, with: "AA")
        //Then
        XCTAssertEqual(mapDataModel.getData(on: 9),"9")
        
        //Given
        let incomingData = ["A","B","C"]
        //When
        mapDataModel.setDataModelWithIncomingChange(with: incomingData)
        //Then
        XCTAssertEqual(mapDataModel.provideData(),incomingData)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
