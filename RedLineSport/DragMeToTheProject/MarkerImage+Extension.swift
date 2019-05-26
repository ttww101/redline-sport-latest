import Foundation
import CoreGraphics
    import UIKit

extension MarkerImage {
func offsetForDrawingDoListen(_ para: Int, isOk: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func refreshContentDoRaise(_ sender: Double, isOk: Bool) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func drawCannotSleep(_ message: Double, title: String) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
}
