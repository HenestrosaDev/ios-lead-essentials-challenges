//
// Copyright © Essential Developer. All rights reserved.
//

import Foundation

internal struct RemoteFeedImage: Decodable {
	internal let image_id: UUID
	internal let image_desc: String?
	internal let image_loc: String?
	internal let image_url: URL
}
