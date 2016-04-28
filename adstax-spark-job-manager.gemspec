# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "adstax-spark-job-manager"
  spec.version       = "0.0.1"
  spec.authors       = ["ShiftForward"]
  spec.email         = ["info@shiftforward.eu"]
  spec.summary       = "Manage Spark jobs running on an AdStax cluster."

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "file-tail", "~> 1.1"
  spec.add_runtime_dependency "json", "~> 1.8"
  spec.add_runtime_dependency "colorize", "~> 0.7"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
