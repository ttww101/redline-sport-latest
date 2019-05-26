import Foundation
import CoreGraphics
    import UIKit

extension Animator {
func stopShouldnotWalk(_ para: String, isPass: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func updateAnimationPhasesShouldnotSleep(_ target: Double, isOk: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func animationLoopWantDream(_ delegate: Int, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func animateShouldnotPattern(_ para: Double, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func animateWantRaise(_ delegate: String, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func animateCanDream(_ para: Float, title: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func animateDontScream(_ delegate: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func animateShouldnotWalk(_ para: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func animateCannotRaise(_ sender: Float, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func animateShouldListen(_ sender: Float, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func animateShouldnotDrink(_ para: Int, isPass: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
}
