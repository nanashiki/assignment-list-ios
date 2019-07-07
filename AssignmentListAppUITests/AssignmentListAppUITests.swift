//
//  AssignmentListAppUITests.swift
//  AssignmentListAppUITests
//
//  Created by nanashiki on 2019/05/25.
//  Copyright © 2019 nanashiki. All rights reserved.
//

import XCTest

class AssignmentListAppUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let app = XCUIApplication()

        XCTAssert(app.navigationBars["課題"].exists, "課題のナビゲーションバーが存在しません")
        
        app.navigationBars["課題"].buttons["Add"].tap()
        
        XCTAssert(app.alerts["課題の追加"].exists, "課題の追加のアラートが存在しません")
        XCTAssert(app.alerts["課題の追加"].textFields.firstMatch.exists, "課題の追加のアラートにテキストフィールドが存在しません")
        XCTAssert(app.alerts["課題の追加"].buttons["キャンセル"].exists, "課題の追加のアラートにキャンセルボタンが存在しません")
        XCTAssert(app.alerts["課題の追加"].buttons["保存"].exists, "課題の追加のアラートに保存ボタンが存在しません")

        app.alerts["課題の追加"].textFields.firstMatch.typeText("John Smith")
        app.alerts["課題の追加"].buttons["保存"].tap()

        XCTAssert(app.cells.staticTexts["John Smith"].exists, "John Smithが存在しません")
        
        app.cells.staticTexts["John Smith"].tap()
        
        XCTAssert(app.alerts["完了しますか？"].exists, "完了しますか？の追加のアラートが存在しません")
        XCTAssert(app.alerts["完了しますか？"].buttons["キャンセル"].exists, "完了しますか？のアラートにキャンセルボタンが存在しません")
        XCTAssert(app.alerts["完了しますか？"].buttons["OK"].exists, "完了しますか？のアラートに保存ボタンが存在しません")
        
        app.alerts["完了しますか？"].buttons["OK"].tap()
        
        XCTAssert(!app.cells.staticTexts["John Smith"].exists, "John Smithが存在します")
    }
    
    func testTextFieldTextValidation() {
        let app = XCUIApplication()
        
        XCTAssert(app.navigationBars["課題"].exists, "課題のナビゲーションバーが存在しません")
        
        app.navigationBars["課題"].buttons["Add"].tap()
        
        XCTAssert(app.alerts["課題の追加"].exists, "課題の追加のアラートが存在しません")
        XCTAssert(app.alerts["課題の追加"].textFields.firstMatch.exists, "課題の追加のアラートにテキストフィールドが存在しません")
        XCTAssert(app.alerts["課題の追加"].buttons["キャンセル"].exists, "課題の追加のアラートにキャンセルボタンが存在しません")
        XCTAssert(app.alerts["課題の追加"].buttons["保存"].exists, "課題の追加のアラートに保存ボタンが存在しません")
        
        
        XCTAssert(!app.alerts["課題の追加"].buttons["保存"].isEnabled, "課題の追加のアラートに保存ボタンはテキストフィールドが空白の場合は押せてはいけません")
        app.alerts["課題の追加"].textFields.firstMatch.typeText("John Smith")
        XCTAssert(app.alerts["課題の追加"].buttons["保存"].isEnabled, "課題の追加のアラートに保存ボタンはテキストフィールドに入力されている場合は推せる必要があります")
        let deleteString = "John Smith".map { _ in XCUIKeyboardKey.delete.rawValue }.joined(separator: "")
        
        app.alerts["課題の追加"].textFields.firstMatch.typeText(deleteString)
        XCTAssert(!app.alerts["課題の追加"].buttons["保存"].isEnabled, "課題の追加のアラートに保存ボタンはテキストフィールドが空白の場合は押せてはいけません")
        
    }
}
