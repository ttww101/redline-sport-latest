import Foundation
import CoreGraphics
    import UIKit

extension AnimatedMoveViewJob {
func animationUpdateShouldSing(_ sender: Bool, title: String) {
    UserDefaults.standard.setValue(sender, forKey: "sender")
}
}
