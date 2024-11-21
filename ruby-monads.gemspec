Gem::Specification.new do |s|
  s.name = "ruby-monads"
  s.version = "0.3.0"
  s.summary = "Some common monads"
  s.description = "Simple and minimalist ruby implementation of some common monads"
  s.author = "Guillaume BOUDON"
  s.email = "guillaumeboudon@gmail.com"
  s.homepage = "https://github.com/guillaumeboudon/ruby-monads"
  s.license = "MIT"

  s.files = `git ls-files`.split("\n")

  s.add_development_dependency "cutest", "~> 1.2", ">= 1.2.3"
  s.add_development_dependency "rubocop", "~> 1", ">= 1.68"
  s.add_development_dependency "standard", "~> 1.42", ">= 1.42.1"
end
