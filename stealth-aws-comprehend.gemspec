Gem::Specification.new do |s|
  s.name        = 'stealth-aws-comprehend'
  s.version     = '0.9.1'
  s.summary     = "Stealth AWS Comprehend"
  s.description = "Built-in NLP for Stealth bots via AWS Comprehend."
  s.authors     = ["Mauricio Gomes"]
  s.email       = 'mauricio@edge14.com'
  s.files       = `git ls-files`.split("\n")
  s.homepage    = 'http://github.com/hellostealth/stealth-aws-comprehend'
  s.license     = 'MIT'

  s.add_dependency 'stealth', '< 2.0'
  s.add_dependency 'aws-sdk-comprehend', '~> 1.0'

  s.add_development_dependency "rspec", "3.6.0"

end
