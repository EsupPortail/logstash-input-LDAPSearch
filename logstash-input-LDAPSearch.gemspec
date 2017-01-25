Gem::Specification.new do |s|

  s.name            = 'logstash-input-LDAPSearch'
  s.version         = '0.2.0'
  s.licenses        = ['Apache License (2.0)']
  s.summary         = "logstash input plugin to perform search into ldap."
  s.description     = "This gem is a logstash plugin required to be installed on top of the Logstash core pipeline using $LS_HOME/bin/plugin install gemname. This gem is not a stand-alone program"
  s.authors         = ["Nicolas CAN"]
  s.email           = 'nicolas.can@univ-lille1.fr'
  s.homepage        = "http://www.elastic.co/guide/en/logstash/current/index.html"
  s.require_paths = ["lib"]

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']

  # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "input" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core", '~> 5.0'

  s.add_runtime_dependency 'jruby-ldap','~> 0'
  #s.add_runtime_dependency 'ruby_base64'
  
  #s.add_runtime_dependency 'logstash-codec-plain'
  #s.add_runtime_dependency 'logstash-codec-line'
  #s.add_runtime_dependency 'logstash-codec-json'
  #s.add_runtime_dependency 'logstash-codec-json_lines'
  #s.add_runtime_dependency 'concurrent-ruby'

  s.add_development_dependency 'logstash-devutils','~> 0'
end
