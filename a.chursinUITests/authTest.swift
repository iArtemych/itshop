import XCTest

class authTest: XCTestCase
{
    var app: XCUIApplication!
        
    override func setUp()
    {
        super.setUp()
        
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown()
    {
        
        super.tearDown()
    }
    
    func testExample()
    {
        app.tabBars.buttons["Accaunt"].tap()
        app.buttons["Log in"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["First time here? Register"]/*[[".scrollViews.buttons[\"First time here? Register\"]",".buttons[\"First time here? Register\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let scrollViewsQuery = app.scrollViews
        
        let textFieldLogin = scrollViewsQuery.children(matching: .textField).element(boundBy: 0)
        textFieldLogin.tap()
        textFieldLogin.typeText("Diana")
        
        let secureTextField = scrollViewsQuery.children(matching: .secureTextField).element
        secureTextField.tap()
        secureTextField.typeText("Diana")

        app/*@START_MENU_TOKEN@*/.segmentedControls/*[[".scrollViews.segmentedControls",".segmentedControls"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Female"].tap()

        app/*@START_MENU_TOKEN@*/.scrollViews.containing(.button, identifier:"< Back").element/*[[".scrollViews.containing(.button, identifier:\"Apply\").element",".scrollViews.containing(.staticText, identifier:\"About you\").element",".scrollViews.containing(.staticText, identifier:\"Credit Card\").element",".scrollViews.containing(.staticText, identifier:\"E-mail\").element",".scrollViews.containing(.staticText, identifier:\"Gender\").element",".scrollViews.containing(.staticText, identifier:\"Password\").element",".scrollViews.containing(.staticText, identifier:\"Login\").element",".scrollViews.containing(.staticText, identifier:\"Accaunt\").element",".scrollViews.containing(.button, identifier:\"< Back\").element"],[[[-1,8],[-1,7],[-1,6],[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Apply"]/*[[".scrollViews.buttons[\"Apply\"]",".buttons[\"Apply\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.scrollViews.containing(.button, identifier:"Close")/*[[".scrollViews.containing(.button, identifier:\"First time here? Register\")",".scrollViews.containing(.button, identifier:\"Login\")",".scrollViews.containing(.staticText, identifier:\"ITshop\")",".scrollViews.containing(.button, identifier:\"Close\")"],[[[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .textField).element.tap()
        
        let loginAccauntTextField = scrollViewsQuery.children(matching: .textField).element
        loginAccauntTextField.tap()
        loginAccauntTextField.typeText("Diana")
        
        let securePassword = secureTextField
        securePassword.tap()
        securePassword.typeText("Diana")

        app/*@START_MENU_TOKEN@*/.buttons["Login"]/*[[".scrollViews.buttons[\"Login\"]",".buttons[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        
        app.buttons["Edit"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["< Back"]/*[[".scrollViews.buttons[\"< Back\"]",".buttons[\"< Back\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Logout"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["Close"]/*[[".scrollViews.buttons[\"Close\"]",".buttons[\"Close\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
}
