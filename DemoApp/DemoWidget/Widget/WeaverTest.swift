class Root {
	let dependencies = RootDependencyContainer()

	// weaver: vc1 = VC1
	// weaver: vc1.scope = .transient

	func main() {
		_ = vc1
	}
}

extension Root {
	var vc1: VC1 { return dependencies.vc1 }
}

class VC1 {
	let dependencies: VC1DependencyResolver

	// weaver: nav = Nav1
	// weaver: nav.scope = .container

	// weaver: log = Log1
	// weaver: log.scope = .container

	init(injecting dependencies: VC1DependencyResolver) {
		self.dependencies = dependencies
	}
}

class Nav1 {
	let dependencies: Nav1DependencyResolver

	// weaver: vc2 = VC2
	// weaver: vc2.scope = .transient

	init(injecting dependencies: Nav1DependencyResolver) {
		self.dependencies = dependencies
	}
}

class Log1 {
	let dependencies: Log1DependencyResolver

	// weaver: nav <- Nav1

	init(injecting dependencies: Log1DependencyResolver) {
		self.dependencies = dependencies
	}
}

class VC2 {
	let dependencies: VC2DependencyResolver

	// weaver: log2 = Log2
	// weaver: log2.scope = .container

	init(injecting dependencies: VC2DependencyResolver) {
		self.dependencies = dependencies
	}
}

class Log2 {
	let dependencies: Log2DependencyResolver

	// weaver: forceGenerate = Bool

	init(injecting dependencies: Log2DependencyResolver) {
		self.dependencies = dependencies
	}
}
