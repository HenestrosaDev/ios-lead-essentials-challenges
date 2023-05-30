//
//  Copyright © Essential Developer. All rights reserved.
//

import XCTest
import FeedStoreChallenge

extension FeedStoreSpecs where Self: XCTestCase {
	
	func assertThatRetrieveDeliversEmptyOnEmptyCache(
		on sut: FeedStore,
		file: StaticString = #filePath,
		line: UInt = #line
	) {
		expect(sut, toRetrieve: .empty, file: file, line: line)
	}

	func assertThatRetrieveHasNoSideEffectsOnEmptyCache(
		on sut: FeedStore,
		file: StaticString = #filePath,
		line: UInt = #line
	) {
		expect(sut, toRetrieveTwice: .empty, file: file, line: line)
	}

	func assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(
		on sut: FeedStore,
		file: StaticString = #filePath,
		line: UInt = #line
	) {
		let feed = uniqueImageFeed()
		let timestamp = Date()

		insert((feed, timestamp), to: sut)

		expect(sut, toRetrieve: .found(feed: feed, timestamp: timestamp), file: file, line: line)
	}

	func assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(
		on sut: FeedStore,
		file: StaticString = #filePath,
		line: UInt = #line
	) {
		let feed = uniqueImageFeed()
		let timestamp = Date()

		insert((feed, timestamp), to: sut)

		expect(sut, toRetrieveTwice: .found(feed: feed, timestamp: timestamp), file: file, line: line)
	}

	func assertThatInsertDeliversNoErrorOnEmptyCache(
		on sut: FeedStore,
		file: StaticString = #filePath,
		line: UInt = #line
	) {
		let insertionError = insert((uniqueImageFeed(), Date()), to: sut)

		XCTAssertNil(insertionError, "Expected to insert cache successfully", file: file, line: line)
	}

	func assertThatInsertDeliversNoErrorOnNonEmptyCache(
		on sut: FeedStore,
		file: StaticString = #filePath,
		line: UInt = #line
	) {
		insert((uniqueImageFeed(), Date()), to: sut)

		let insertionError = insert((uniqueImageFeed(), Date()), to: sut)

		XCTAssertNil(insertionError, "Expected to override cache successfully", file: file, line: line)
	}

	func assertThatInsertOverridesPreviouslyInsertedCacheValues(
		on sut: FeedStore,
		file: StaticString = #filePath,
		line: UInt = #line
	) {
		insert((uniqueImageFeed(), Date()), to: sut)

		let latestFeed = [LocalFeedImage]()
		let latestTimestamp = Date()
		insert((latestFeed, latestTimestamp), to: sut)

		expect(sut, toRetrieve: .found(feed: latestFeed, timestamp: latestTimestamp), file: file, line: line)
	}

	func assertThatDeleteDeliversNoErrorOnEmptyCache(
		on sut: FeedStore,
		file: StaticString = #filePath,
		line: UInt = #line
	) {
		let deletionError = deleteCache(from: sut)

		XCTAssertNil(deletionError, "Expected empty cache deletion to succeed", file: file, line: line)
	}

	func assertThatDeleteHasNoSideEffectsOnEmptyCache(
		on sut: FeedStore,
		file: StaticString = #filePath,
		line: UInt = #line
	) {
		deleteCache(from: sut)

		expect(sut, toRetrieve: .empty, file: file, line: line)
	}

	func assertThatDeleteDeliversNoErrorOnNonEmptyCache(
		on sut: FeedStore,
		file: StaticString = #filePath,
		line: UInt = #line
	) {
		insert((uniqueImageFeed(), Date()), to: sut)

		let deletionError = deleteCache(from: sut)

		XCTAssertNil(deletionError, "Expected non-empty cache deletion to succeed", file: file, line: line)
	}

	func assertThatDeleteEmptiesPreviouslyInsertedCache(
		on sut: FeedStore,
		file: StaticString = #filePath,
		line: UInt = #line
	) {
		insert((uniqueImageFeed(), Date()), to: sut)

		deleteCache(from: sut)

		expect(sut, toRetrieve: .empty, file: file, line: line)
	}

	func assertThatSideEffectsRunSerially(
		on sut: FeedStore,
		file: StaticString = #filePath,
		line: UInt = #line
	) {
		let op1 = expectation(description: "Operation 1")
		sut.insert(uniqueImageFeed(), timestamp: Date()) { _ in
			op1.fulfill()
		}

		let op2 = expectation(description: "Operation 2")
		sut.deleteCachedFeed { _ in
			op2.fulfill()
		}

		let op3 = expectation(description: "Operation 3")
		sut.insert(uniqueImageFeed(), timestamp: Date()) { _ in
			op3.fulfill()
		}

		let op4 = expectation(description: "Operation 4")
		sut.retrieve { _ in
			op4.fulfill()
		}

		wait(for: [op1, op2, op3, op4], timeout: 5.0, enforceOrder: true)
	}
	
}
