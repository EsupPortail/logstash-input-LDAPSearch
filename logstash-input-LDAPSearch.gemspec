Gem::Specification.new do |s|

  s.name            = 'logstash-input-LDAPSearch'
  s.version         = '0.3.0'
  s.licenses        = ['Apache-2.0']
  s.summary         = 'logstash input plugin to perform search into ldap.'
  s.description     = 'This gem is a logstash plugin required to be installed on top of the Logstash core pipeline using $LS_HOME/bin/logstash-plugin install gemname. This gem is not a stand-alone program'
  s.authors         = ['Guillaume Colson', 'Jean-Albert Vescovo', 'Nicolas.Can@univ-lille.fr']
  s.email           = 'guillaume.colson@univ-lorraine.fr'
  s.homepage        = 'https://github.com/EsupPortail/logstash-input-LDAPSearch' #'http://www.elastic.co/guide/en/logstash/current/index.html'
  s.require_paths = ['lib']

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']

  # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { 'logstash_plugin' => 'true', 'logstash_group' => 'input' }

  # Gem dependencies
  s.add_runtime_dependency 'logstash-core-plugin-api', '>= 1.60', '<= 2.99'
  s.add_runtime_dependency 'net-ldap', '~> 0.16'
  s.add_runtime_dependency 'jruby-ldap', '~> 0'

  s.add_development_dependency 'logstash-devutils', '~> 0'
end
