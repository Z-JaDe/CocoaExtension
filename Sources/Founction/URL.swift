import Foundation

extension URL {
    public var urlComponents: URLComponents? {
        return URLComponents(url: self, resolvingAgainstBaseURL: true)
    }
    public var queryParameters: [String: String]? {
        guard let components = self.urlComponents, let queryItems = components.queryItems else {
            return nil
        }

        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }

        return parameters
    }

    public mutating func addQueryParameter(withName name: String, value: String) {
        guard var urlComponents = self.urlComponents else {
            return
        }
        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? [URLQueryItem]()
        if let index = queryItems.index(where: {$0.name == name}) {
            queryItems[index].value = value
        } else {
            queryItems.append(URLQueryItem(name: name, value: value))
        }
        urlComponents.queryItems = queryItems

        self = urlComponents.url!
    }
}

extension String {
    /// ZJaDe: 提取所有URl
    public var extractURLs: [URL] {
        var urls: [URL] = []
        let detector: NSDataDetector?
        do {
            detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        } catch _ as NSError {
            detector = nil
        }

        let text = self

        if let detector = detector {
            detector.enumerateMatches(in: text, options: [], range: NSRange(location: 0, length: text.count), using: { (result: NSTextCheckingResult?, _: NSRegularExpression.MatchingFlags, _: UnsafeMutablePointer<ObjCBool>) -> Void in
                if let result = result, let url = result.url {
                    urls.append(url)
                }
            })
        }
        return urls
    }
}
