//import XCTest
//
//class basketTest: XCTestCase
//{
//    var app: XCUIApplication!
//    
//    override func setUp()
//    {
//        super.setUp()
//        
//        continueAfterFailure = false
//        
//        app = XCUIApplication()
//        app.launch()
//    }
//    
//    override func tearDown()
//    {
//        
//        super.tearDown()
//    }
//    
//    func testExample()
//    {
//        app.tabBars.buttons["Accaunt"].tap()
//        app.buttons["Log in"].tap()
//        let scrollViewsQuery = app.scrollViews
//
//        let textFieldLogin = scrollViewsQuery.children(matching: .textField).element(boundBy: 0)
//        textFieldLogin.tap()
//        textFieldLogin.typeText("Diana")
//
//
//        let secureTextField = scrollViewsQuery.children(matching: .secureTextField).element
//        secureTextField.tap()
//        secureTextField.typeText("Diana")
//        
//        app/*@START_MENU_TOKEN@*/.buttons["Login"]/*[[".scrollViews.buttons[\"Login\"]",".buttons[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        
//        app.tabBars.buttons["Shop"].tap()
//        app.navigationBars["ITShop"].buttons["Basket"].tap()
//        
//        let tablesQuery = app.tables
//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Ноутбук"]/*[[".cells.staticTexts[\"Ноутбук\"]",".staticTexts[\"Ноутбук\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
//        tablesQuery.buttons["Delete"].tap()
//        app.navigationBars["Basket"].buttons["ITShop"].tap()
//        
//        app.tabBars.buttons["Accaunt"].tap()
//        app.buttons["Logout"].tap()
//    }
//}
