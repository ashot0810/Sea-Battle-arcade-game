//
//  UnitTestsForDataSourceForBattleViewController.swift
//  Sea Battle Tests
//
//  Created by Ashot Hovhannisyan on 18.10.23.
//

import XCTest
@testable import Sea_Battle

final class UnitTestsForDataSourceForBattleViewController: XCTestCase {

    var dataModelForBattle: DataSourceForBattleViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataModelForBattle = DataSourceForBattleViewController(dataForSelfMapSection: ["A","B","C"])
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dataModelForBattle = nil
    }

    func testExample()  {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        //Given
        let dataForOpponentMapSection: [String] = {
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
        //When
        
        //Then
        XCTAssertEqual(dataModelForBattle.provideDataForSelfMapSection(), ["A","B","C"])
        XCTAssertEqual(dataModelForBattle.provideDataForOpponentMapSection(), dataForOpponentMapSection)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
