Gem::Specification.new do |s|
  s.name = "conway"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Yoho"]
  s.date = %q{2011-01-21}
  s.description = %q{
     A simple implementation of Conway's Game of Life with an ASCII visualizer
    }
  s.email = %q{mby@mattyoho.com}
  s.extra_rdoc_files = [
    "MIT-LICENSE",
    "README.md"
  ]
  s.files = [ "MIT-LICENSE", "README.md"] + Dir['lib/**/*']
  s.homepage = %q{http://github.com/mattyoho/conway}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = ">= 1.3.5"
  s.summary = s.description + ". This version has fewer significant reference leaks."
  s.test_files = Dir['spec/**/*']
  s.specification_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
  s.add_dependency('choice', '0.1.4')

  s.executables        = %w(conway)
  s.default_executable = "conway"
end

