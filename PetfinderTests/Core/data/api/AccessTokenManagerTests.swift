//
//  AccessTokenManagerTests.swift
//  PetfinderTests
//
//  Created by Timur Cheberda on 23.04.2022.
//

import XCTest
@testable import Petfinder

class AccessTokenManagerTests: XCTestCase {
    
    private var accessTokenManager: AccessTokenManagerProtocol?
    let token = AccessTokenTestHelper.randomAPIToken()
    
    override func setUp() {
        super.setUp()
        
        guard let userDefaults = UserDefaults(suiteName: #file) else { return }

        userDefaults.removePersistentDomain(forName: #file)
        userDefaults.set(token.expiresAt.timeIntervalSince1970, forKey: AppUserDefaultsKeys.expiresAt)
        userDefaults.set(token.bearerAccessToken, forKey: AppUserDefaultsKeys.bearerAccessToken)

        accessTokenManager = AccessTokenManager(userDefaults: userDefaults)
    }
    
    func testRequestToken() {
        guard let token = accessTokenManager?.fetchToken() else {
            XCTFail("Didn't get token from the access token manager")
            return
        }
        
        XCTAssertFalse(token.isEmpty)
    }
    
    func testCachedToken() {
        guard let sameToken = accessTokenManager?.fetchToken() else {
            XCTFail("Didn't get token from the access token manager")
            return
        }

        XCTAssertEqual(token.bearerAccessToken, sameToken)
    }
    
    func testRefreshToken() throws {
        let randomToken = AccessTokenTestHelper.randomAPIToken()
        
        guard let accessTokenManager = accessTokenManager else {
            XCTFail("Access token manager object is nil")
            return
        }
        
        try accessTokenManager.refreshWith(apiToken: randomToken)
        
        XCTAssertNotEqual(token.bearerAccessToken, accessTokenManager.fetchToken())
        XCTAssertEqual(randomToken.bearerAccessToken, accessTokenManager.fetchToken())
    }
    
}
