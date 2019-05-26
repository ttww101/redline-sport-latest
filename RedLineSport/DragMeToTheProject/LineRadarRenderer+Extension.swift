import Foundation
import CoreGraphics

extension LineRadarRenderer {
func drawFilledPathWantJump(_ delegate: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func drawFilledPathCanLook(_ delegate: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
}
