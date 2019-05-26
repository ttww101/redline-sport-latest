import Foundation
import CoreGraphics
    import UIKit

extension MarkerView {
func offsetForDrawingDontDance(_ para: Int, title: String) {
    UserDefaults.standard.setValue(para, forKey: "para")
}
func refreshContentDontWantDream(_ element: Bool, isPass: Bool) {
    UserDefaults.standard.setValue(element, forKey: "element")
}
func drawWantSleep(_ target: Double, isPass: Bool) {
    UserDefaults.standard.setValue(target, forKey: "target")
}
func viewFromXibCanListen(_ listener: Double, isOk: Bool) {
    UserDefaults.standard.setValue(listener, forKey: "listener")
}
}
