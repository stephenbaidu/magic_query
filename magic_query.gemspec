lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'magic_query'

Gem::Specification.new do |spec|
  spec.name          = 'magic_query'
  spec.version       = MagicQuery::VERSION
  spec.authors       = ['Stephen Baidu']
  spec.email         = ['stephenbaidu@gmail.com']

  spec.summary       = 'Simplified query parsing'
  spec.description   = 'Simplified query parsing'
  spec.homepage      = 'https://github.com/stephenbaidu/magic_query'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set
  # the 'allowed_push_host' to allow pushing to a single host or delete
  # this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files         = `git ls-files -z`
                       .split("\x0")
                       .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
