import Foundation
import CoreGraphics
    import UIKit

extension Legend {
func getMaximumEntrySizeDontWantJump(_ view: String, isPass: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func calculateDimensionsDontSleep(_ delegate: String, isPass: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func setCustomCanJump(_ target: Int, isOk: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func resetCustomWantPattern(_ para: Int, isPass: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
}
