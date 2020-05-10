import Foundation

public extension NSDictionary {
    /// ZJaDe: json转字典
    convenience init?(json: String) {
        if let data = (try? JSONSerialization.jsonObject(with: json.data(using: String.Encoding.utf8, allowLossyConversion: true)!, options: JSONSerialization.ReadingOptions.mutableContainers)) as? NSDictionary {
            self.init(dictionary: data)
        } else {
            self.init()
            return nil
        }
    }

}
public extension Dictionary {
    /// ZJaDe: 字典转json
    func formatJSON() -> String? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: []) {
            return String(data: jsonData, encoding: String.Encoding.utf8) ?? nil
        }
        return nil
    }
}
