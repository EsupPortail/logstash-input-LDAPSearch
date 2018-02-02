# encoding: utf-8
require "logstash/inputs/base"
require "logstash/namespace"
require "stud/interval"
require "socket"

class LogStash::Inputs::LDAPSearch < LogStash::Inputs::Base
        config_name "LDAPSearch"

        # If undefined, Logstash will complain, even if codec is unused.
        default :codec, "plain"

        # LDAP parameters
        config :host, :validate => :string, :required => true
        config :dn, :validate => :string, :required => true
        config :password, :validate => :password, :required => true
        config :filter, :validate => :string, :required => true
        config :base, :validate => :string, :required => true
        config :port, :validate => :number, :default => 389
        config :usessl, :validate => :boolean, :default => false
        config :attrs, :validate => :array, :default => ['uid']

        public
        def register
                require 'base64'
                require 'rubygems'
                require 'net/ldap'
        end # def register

        public
        def run(queue)
                 begin
                        @host = Socket.gethostbyname(@host).first
                        #Managing Socket exception
                        rescue SocketError => se
                              puts "Got socket error: #{se}"
                              exit
                end
                begin
                        if @usessl == true
                                conn = Net::LDAP.new :host => @host,
                                                     :port => @port,
                                                     :encryption => :simple_tls,
                                                     :base => base,
                                                     :auth => {
                                                        :method => :simple,
                                                        :username => @dn,
                                                        :password => @password.value
                                                     }
                        else
                                conn = Net::LDAP.new :host => @host,
                                                     :port => @port,
                                                     :base => base,
                                                     :auth => {
                                                        :method => :simple,
                                                        :username => @dn,
                                                        :password => @password.value
                                                     }
                        end

                        # Handling binding exception
                        if ! conn.bind
                                puts "Connection failed - code:  #{conn.get_operation_result.code}: #{conn.get_operation_result.message}"
                        end

                        # Instantiating a LDAP filter
                        search_filter = Net::LDAP::Filter.from_rfc2254(filter)

                        # Lauching LDAP request
                        conn.search( :filter => search_filter, :attributes => attrs ) { |entry|
                                event = LogStash::Event.new
                                decorate(event)
                                event.set("host",@host)
                                entry.attribute_names.each { |attr|
                                        # Changing attribute variable type returned by attribute_name method from Symbol to String
                                        attr = attr.to_s
                                        # Suppressing default dn attribute if not wanted
                                        next if (/^dn$/ =~ attr)
                                        values = entry[attr]
                                        # Formatting sAMAccountName to match classic case
                                        attr = "sAMAccountName" if attr == "samaccountname"
                                        values = values.map { |value|
                                                (/[^[:print:]]/ =~ value).nil? ? value : Base64.strict_encode64(value)
                                        }
                                        # Populating event
                                        event.set(attr,values)
                                }
                                # Adding event and sending to logstash for processing
                                queue << event
                        }
                        #Managing LDAP exception
                        rescue Net::LDAP::Error => le
                                puts "Got LDAP error: #{le}"
                                exit
                end
                # finished
        end # def run

end # class LogStash::Inputs::LDAPSearch
