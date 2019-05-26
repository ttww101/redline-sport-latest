import Foundation

extension NSUIView {
func touchesBeganShouldDream(_ delegate: Bool, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func touchesMovedDontWantSing(_ sender: Int, title: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func touchesEndedShouldnotWalk(_ listener: Float, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func touchesCancelledDontWantListen(_ listener: Double, isOk: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func nsuiTouchesBeganDontWantSpeak(_ para: String, title: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func nsuiTouchesMovedDoEat(_ message: Float, contents: Float, subtitle: String) {
    UserDefaults.standard.setValue(message, forKey: "message")
}
func nsuiTouchesEndedShouldnotListen(_ target: String, title: String) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func nsuiTouchesCancelledDontWantClimb(_ target: String, title: String) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
}
import Foundation

extension NSUIView {
func setNeedsDisplayDoSing(_ sender: Int, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func touchesBeganDoLook(_ listener: Double, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
func touchesEndedShouldRaise(_ para: Double, isOk: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func touchesMovedCanDream(_ sender: Double, isPass: Bool) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
func touchesCancelledShouldRun(_ delegate: Int, models: Double, title: String, isGood: Float) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func nsuiTouchesBeganDoRun(_ view: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
func nsuiTouchesMovedDontWantPattern(_ para: Int, isPass: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func nsuiTouchesEndedCanWalk(_ para: String, isPass: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func nsuiTouchesCancelledDontWalk(_ view: Int, isOk: Bool) {
    UserDefaults.standard.setValue(view, forKey: "view")
}
}
