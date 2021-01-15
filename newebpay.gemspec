# frozen_string_literal: true

require_relative 'lib/newebpay/version'

Gem::Specification.new do |spec|
  spec.name          = 'NewebPay'
  spec.version       = Newebpay::VERSION
  spec.authors       = ['Aotokitsuruya']
  spec.email         = ['contact@frost.tw']

  spec.summary       = 'The offsite payments implemented for NewebPay'
  spec.description   = 'The offsite payments implemented for NewebPay'
  spec.homepage      = 'https://github.com/elct9620/newebpay-ruby'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/elct9620/newebpay-ruby'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
