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
        client.get(from: url) { (result) in
            switch result{
            case let .success(data, resp):
                completion(FeedItemsMapper.map(data, from: resp))
                
            case .failure:
                completion(.failure(RemoteFeedLoader.Error.connectivity))
            }
        }
//        client.get(from: url) { result in
//            switch result{
//            case .success(Dataresponse, response):
//                completion(.failure(RemoteFeedLoader.Error.invalidData))
//            case .failure(error):
//                completion(.failure(RemoteFeedLoader.Error.connectivity))
//            }
//
//        }
    }
}
