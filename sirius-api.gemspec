Gem::Specification.new do |spec|
  spec.name = "sirius-api"
  spec.version = "1.0.0"
  spec.authors = ["Arda Tetik"]
  spec.email = ["ardatetik1881@gmail.com"]

  spec.summary = "Sirius API interactions with Ruby"
  spec.description = "Sirius API interactions with Ruby"
  spec.required_ruby_version = ">= 3.1.0"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end

  spec.files = Dir["lib/**/*.rb"]
  spec.require_paths = ["lib"]
end