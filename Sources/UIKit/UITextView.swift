import UIKit

extension UITextView {
    #if os(iOS)

    /// ZJaDe: Automatically adds a toolbar with a done button to the top of the keyboard. Tapping the button will dismiss the keyboard.
    public func addDoneButton(_ barStyle: UIBarStyle = .default, title: String? = nil) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: title ?? "完成", style: .done, target: self, action: #selector(resignFirstResponder))
        ]

        keyboardToolbar.barStyle = barStyle
        keyboardToolbar.sizeToFit()

        inputAccessoryView = keyboardToolbar
    }

    #endif
}
