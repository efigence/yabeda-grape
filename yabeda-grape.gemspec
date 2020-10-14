lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "yabeda/grape/version"

Gem::Specification.new do |spec|
  spec.name          = 'yabeda-grape'
  spec.version       = Yabeda::Grape::VERSION
  spec.authors       = ["Vadym Filipov"]
  spec.email         = ["vfilipov@efigence.com"]

  spec.summary       = 'Extensible metrics for monitoring Grape API endpoints'
  spec.description   = 'Easy collecting your Grape endpoints metrics'
  spec.homepage      = 'https://github.com/efigence/yabeda-grape'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "yabeda"
  spec.add_dependency "grape"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.0"
end
