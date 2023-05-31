//
//  Copyright © Essential Developer. All rights reserved.
//

import XCTest
import FeedStoreChallenge

class FeedStoreIntegrationTests: XCTestCase {
	//  ***********************
	//
	//  [DO NOT DELETE THIS COMMENT]
	//
	//  Implement these Integration Tests *after*
	//  you're done with all the `FeedStoreChallengeTests`
	//
	//  Follow the TDD process:
	//
	//  1. Uncomment and run one test at a time (run tests with CMD+U).
	//  2. Do the minimum to make the test pass and commit.
	//  3. Refactor if needed and commit again.
	//
	//  Repeat this process until all tests are passing.
	//
	//  ***********************

	override func setUpWithError() throws {
		try super.setUpWithError()

		try setupEmptyStoreState()
	}

	override func tearDownWithError() throws {
		try undoStoreSideEffects()

		try super.tearDownWithError()
	}

	func test_retrieve_deliversEmptyOnEmptyCache() throws {
		let sut = try makeSUT()

		expect(sut, toRetrieve: .empty)
	}

	func test_retrieve_deliversFeedInsertedOnAnotherInstance() throws {
		let storeToInsert = try makeSUT()
		let storeToLoad = try makeSUT()
		let feed = uniqueImageFeed()
		let timestamp = Date()

		insert((feed, timestamp), to: storeToInsert)

		expect(storeToLoad, toRetrieve: .found(feed: feed, timestamp: timestamp))
	}

	func test_insert_overridesFeedInsertedOnAnotherInstance() throws {
		let storeToInsert = try makeSUT()
		let storeToOverride = try makeSUT()
		let storeToLoad = try makeSUT()

		insert((uniqueImageFeed(), Date()), to: storeToInsert)

		let latestFeed = uniqueImageFeed()
		let latestTimestamp = Date()
		insert((latestFeed, latestTimestamp), to: storeToOverride)

		expect(storeToLoad, toRetrieve: .found(feed: latestFeed, timestamp: latestTimestamp))
	}

	func test_delete_deletesFeedInsertedOnAnotherInstance() throws {
		let storeToInsert = try makeSUT()
		let storeToDelete = try makeSUT()
		let storeToLoad = try makeSUT()

		insert((uniqueImageFeed(), Date()), to: storeToInsert)

		deleteCache(from: storeToDelete)

		expect(storeToLoad, toRetrieve: .empty)
	}

	// - MARK: Helpers

	private func makeSUT(file: StaticString = #filePath, line: UInt = #line) throws -> FeedStore {
		let sut = try CoreDataFeedStore(storeURL: testSpecificStoreURL())
		trackForMemoryLeaks(sut, file: file, line: line)
		return sut
	}

	private func setupEmptyStoreState() throws {
		deleteStoreArtifacts()
	}

	private func undoStoreSideEffects() throws {
		deleteStoreArtifacts()
	}

	private func deleteStoreArtifacts() {
		try? FileManager.default.removeItem(at: testSpecificStoreURL())
	}

	private func testSpecificStoreURL() -> URL {
		cachesDirectory().appendingPathComponent("\(type(of: self)).store")
	}

	private func cachesDirectory() -> URL {
		FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
	}
}
