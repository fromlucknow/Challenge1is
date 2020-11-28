//
//  Copyright © 2018 Essential Developer. All rights reserved.
//

import Foundation

public final class RemoteFeedLoader: FeedLoader {
	private let url: URL
	private let client: HTTPClient
	
	public enum Error: Swift.Error {
		case connectivity
		case invalidData
	}
		
	public init(url: URL, client: HTTPClient) {
		self.url = url
		self.client = client
	}
    public typealias Result = LoadFeedResult
    public func load(completion: @escaping (LoadFeedResult) -> Void) {
        client.get(from: url) {[weak self] (result) in
            if self == nil{
                return
            }
            switch result{
            case let .success(data, resp):
                completion(FeedItemsMapper.map(data, from: resp))
                
            case .failure:
                completion(.failure(RemoteFeedLoader.Error.connectivity))
            }
        }
    }
}
