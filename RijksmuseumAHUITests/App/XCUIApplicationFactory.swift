//
//  XCUIApplicationFactory.swift
//  RijksmuseumAHUITests
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import XCTest

final class XCUIApplicationFactory {
    static func makeApplication(useCase: RijksmuseumAHUITestCase) -> XCUIApplication {
        let app = XCUIApplication()
        app.launchEnvironment = TestEnvironmentBuilder.buildEnviroment(useCase: useCase)
        return app
    }
}
