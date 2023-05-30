//
//  Copyright © Essential Developer. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
	
	static func alwaysFailingFetchStub() -> Stub {
		Stub(
			#selector(NSManagedObjectContext.__execute(_:)),
			#selector(Stub.execute(_:))
		)
	}

	static func alwaysFailingSaveStub() -> Stub {
		Stub(
			#selector(NSManagedObjectContext.save),
			#selector(Stub.save)
		)
	}

	class Stub: NSObject {
		private let source: Selector
		private let destination: Selector

		init(_ source: Selector, _ destination: Selector) {
			self.source = source
			self.destination = destination
		}

		@objc func execute(_: Any) throws -> Any {
			throw anyNSError()
		}

		@objc func save() throws {
			throw anyNSError()
		}

		func startIntercepting() {
			method_exchangeImplementations(
				class_getInstanceMethod(NSManagedObjectContext.self, source)!,
				class_getInstanceMethod(Stub.self, destination)!
			)
		}

		deinit {
			method_exchangeImplementations(
				class_getInstanceMethod(Stub.self, destination)!,
				class_getInstanceMethod(NSManagedObjectContext.self, source)!
			)
		}
	}
	
}
