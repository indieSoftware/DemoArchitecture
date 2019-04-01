import UIKit
import RxSwift
import PlaygroundSupport

// Necessary for asynchronous execution otherwise playground will terminate before they were finished.
PlaygroundPage.current.needsIndefiniteExecution = true

let bag = DisposeBag()
Observable.from(["1", "2", "3"])
	.debug("Foo")
	.subscribe(onNext: { element in
		print(element)
	}).disposed(by: bag)
