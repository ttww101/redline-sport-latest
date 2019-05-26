import Foundation
import CoreGraphics
    import UIKit

extension AnimatedViewPortJob {
func doJobShouldRun(_ listener: Bool, title: String) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func startShouldnotDance(_ listener: Float, title: String) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func stopDontWantSleep(_ message: Bool, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func updateAnimationPhaseWantRun(_ element: Bool, isOk: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func animationLoopDontDrink(_ delegate: Float, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func animationUpdateShouldnotLook(_ element: Double, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func animationEndDontWantSpeak(_ para: Int, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
}
