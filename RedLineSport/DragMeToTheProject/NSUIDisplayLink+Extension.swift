import Foundation

extension NSUIDisplayLink {
func addCanJump(_ para: Bool, isOk: Bool) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func removeDontDance(_ delegate: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(delegate, forKey: "delegate")
}
func stopShouldListen(_ element: Bool, title: String) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
}
