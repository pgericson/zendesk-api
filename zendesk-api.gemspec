# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{zendesk-api}
  s.version = "0.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Peter Ericson"]
  s.date = %q{2010-12-27}
  s.description = %q{RubyGem wrapper for REST API to http://zendesk.com}
  s.email = %q{pg.ericson@gmail.com}
  s.extra_rdoc_files = ["README.markdown", "lib/console.rb", "lib/zendesk-api.rb", "lib/zendesk.rb", "lib/zendesk/attachment.rb", "lib/zendesk/entry.rb", "lib/zendesk/forum.rb", "lib/zendesk/group.rb", "lib/zendesk/main.rb", "lib/zendesk/organization.rb", "lib/zendesk/search.rb", "lib/zendesk/tag.rb", "lib/zendesk/ticket.rb", "lib/zendesk/user.rb", "lib/zendesk/user_identity.rb"]
  s.files = ["Manifest", "README.markdown", "Rakefile", "geminstaller.yml", "lib/console.rb", "lib/zendesk-api.rb", "lib/zendesk.rb", "lib/zendesk/attachment.rb", "lib/zendesk/entry.rb", "lib/zendesk/forum.rb", "lib/zendesk/group.rb", "lib/zendesk/main.rb", "lib/zendesk/organization.rb", "lib/zendesk/search.rb", "lib/zendesk/tag.rb", "lib/zendesk/ticket.rb", "lib/zendesk/user.rb", "lib/zendesk/user_identity.rb", "spec/zendesk/main_spec.rb", "spec/zendesk/user_spec.rb", "zendesk-api.gemspec"]
  s.homepage = %q{http://github.com/pgericson/zendesk-api}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Zendesk-api", "--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{zendesk-api}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{RubyGem wrapper for REST API to http://zendesk.com}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<crack>, [">= 0.1.8"])
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3"])
    else
      s.add_dependency(%q<crack>, [">= 0.1.8"])
      s.add_dependency(%q<activesupport>, [">= 2.3"])
    end
  else
    s.add_dependency(%q<crack>, [">= 0.1.8"])
    s.add_dependency(%q<activesupport>, [">= 2.3"])
  end
end
