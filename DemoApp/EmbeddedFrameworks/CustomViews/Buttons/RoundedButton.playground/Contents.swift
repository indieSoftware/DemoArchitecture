import CustomViews
import PlaygroundSupport
import UIKit

let view = RoundedButton()
view.frame = CGRect(x: 0, y: 0, width: 100, height: 80)
view.setTitle("Title", for: .normal)
PlaygroundPage.current.liveView = view
