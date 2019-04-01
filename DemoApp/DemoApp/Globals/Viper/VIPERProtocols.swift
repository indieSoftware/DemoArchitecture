import Foundation

protocol ViewEvent {}
protocol PresenterCommand {}
protocol InteractorRequest {}
protocol InteractorResponse {}

protocol ResponseListener {
	associatedtype Response: InteractorResponse
	func handle(response: Response)
}

protocol RequestListener {
	associatedtype Request: InteractorRequest
	func handle(request: Request)
}

protocol CommandListener {
	associatedtype Command: PresenterCommand
	func handle(command: Command)
}

protocol EventListener {
	associatedtype Event: ViewEvent
	func handle(event: Event)
}

class AnyRequestListener<T: InteractorRequest>: RequestListener {
	typealias Request = T
	private let handler: (T) -> Void

	init(handler: @escaping ((T) -> Void)) {
		self.handler = handler
	}

	func handle(request: T) {
		handler(request)
	}
}

class AnyResponseListener<T: InteractorResponse>: ResponseListener {
	typealias Response = T
	private let handler: (T) -> Void

	init(handler: @escaping ((T) -> Void)) {
		self.handler = handler
	}

	func handle(response: T) {
		handler(response)
	}
}

class AnyCommandListener<T: PresenterCommand>: CommandListener {
	typealias Command = T
	private let handler: (T) -> Void

	init(handler: @escaping ((T) -> Void)) {
		self.handler = handler
	}

	func handle(command: T) {
		handler(command)
	}
}

class AnyEventListener<T: ViewEvent>: EventListener {
	typealias Event = T
	private let handler: (T) -> Void

	init(handler: @escaping ((T) -> Void)) {
		self.handler = handler
	}

	func handle(event: T) {
		handler(event)
	}
}

protocol Interactor: AnyObject, RequestListener {
	associatedtype Response: InteractorResponse
	var responseListener: AnyResponseListener<Response>? { get set }
}

protocol Presenter: AnyObject, EventListener, ResponseListener {
	associatedtype Command: PresenterCommand
	associatedtype Request: InteractorRequest
	var requestListener: AnyRequestListener<Request>? { get set }
	var commandListener: AnyCommandListener<Command>? { get set }
	var router: Router? { get set }
	var scenePresenter: ScenePresenter? { get set }
}

protocol View: AnyObject, CommandListener {
	associatedtype Event: ViewEvent
	var eventListener: AnyEventListener<Event>? { get set }
}
