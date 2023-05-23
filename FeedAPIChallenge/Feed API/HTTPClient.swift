//
//  Copyright © Essential Developer. All rights reserved.
//

import Foundation

public protocol HTTPClient {
	typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>

	func get(from url: URL, completion: @escaping (Result) -> Void)
}
