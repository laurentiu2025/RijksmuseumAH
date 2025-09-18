//
//  TestEnvironmentBuilder.swift
//  RijksmuseumAHUITests
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import Foundation

final class TestEnvironmentBuilder {
    private static let key = "TestUseCase"
    
    static func buildEnviroment(useCase: RijksmuseumAHUITestCase) -> [String: String] {
        return [TestEnvironmentBuilder.key: useCase.rawValue]
    }
    
    static func readTestCase() -> RijksmuseumAHUITestCase? {
        guard let useCaseRawValue = ProcessInfo.processInfo.environment[TestEnvironmentBuilder.key],
              let useCase = RijksmuseumAHUITestCase(rawValue: useCaseRawValue) else {
            return nil
        }
        
        return useCase
    }
}
