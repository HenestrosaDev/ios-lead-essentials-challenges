//
//  Copyright © Essential Developer. All rights reserved.
//

import CoreData

public extension NSPersistentContainer {
	
	static func load(
		name: String,
		model: NSManagedObjectModel,
		url: URL
	) throws -> NSPersistentContainer {
		let description = NSPersistentStoreDescription(url: url)
		let container = NSPersistentContainer(name: name, managedObjectModel: model)
		container.persistentStoreDescriptions = [description]

		var loadError: Swift.Error?
		container.loadPersistentStores { loadError = $1 }
		try loadError.map { throw $0 }

		return container
	}
	
}

extension NSManagedObjectModel {
	
	convenience init?(name: String, in bundle: Bundle) {
		guard let momd = bundle.url(forResource: name, withExtension: "momd") else {
			return nil
		}
		self.init(contentsOf: momd)
	}
	
}
