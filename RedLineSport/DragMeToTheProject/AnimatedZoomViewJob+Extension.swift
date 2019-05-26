import Foundation
import CoreGraphics

extension AnimatedZoomViewJob {
func animationUpdateDontListen(_ view: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func animationEndCanSleep(_ delegate: Float, title: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
}
