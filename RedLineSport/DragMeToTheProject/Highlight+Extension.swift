import Foundation
import CoreGraphics

extension Highlight {
func setDrawShouldnotLook(_ delegate: Float, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func setDrawShouldSleep(_ listener: String, isPass: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
}
