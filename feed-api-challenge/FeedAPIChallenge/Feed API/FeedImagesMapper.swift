//
// Copyright © Essential Developer. All rights reserved.
//

import Foundation

internal final class FeedImagesMapper {
	private struct Root: Decodable {
		let items: [RemoteFeedImage]
	}

	private static let OK_200 = 200

	internal static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedImage] {
		guard response.statusCode == OK_200,
		      let root = try? JSONDecoder().decode(Root.self, from: data) else {
			throw RemoteFeedLoader.Error.invalidData
		}

		return root.items
	}
}
