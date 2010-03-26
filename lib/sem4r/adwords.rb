# -------------------------------------------------------------------
# Copyright (c) 2009-2010 Giovanni Ferro gf@sem4r.com
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# -------------------------------------------------------------------

require 'rexml/document'
require 'uri'
require 'pp'
require 'logger'

require 'my_active_support/core_ext/hash.rb'

require 'sem4r/credentials'
require 'sem4r/sem4r_error'
require 'sem4r/soap_attributes'

require 'sem4r/base'
require 'sem4r/account'


require 'sem4r/services/service'

#
# common
#
require 'sem4r/common/operation'

#
# adgroup
#
require 'sem4r/ad_group/ad_group_bids'
require 'sem4r/ad_group/mobile_ad_image'
require 'sem4r/ad_group/ad_group'

#
# adgroup_ad
#
require 'sem4r/ad_group_ad/ad_group_ad_operations'
require 'sem4r/ad_group_ad/ad_group_ad'
require 'sem4r/ad_group_ad/ad_group_text_ad'
require 'sem4r/ad_group_ad/ad_group_mobile_ad'

#
# adgroup_criterion
#
require 'sem4r/ad_group_criterion/ad_group_criterion_bids'
require 'sem4r/ad_group_criterion/ad_group_criterion_operations'
require 'sem4r/ad_group_criterion/criterion'
require 'sem4r/ad_group_criterion/criterion_keyword'
require 'sem4r/ad_group_criterion/criterion_placement'
require 'sem4r/ad_group_criterion/ad_group_criterion'

#
# ad_param
#
require 'sem4r/ad_param/ad_param'

#
# bulk_mutate_job
#
require 'sem4r/bulk_mutate_job/job_operations'
require 'sem4r/bulk_mutate_job/bulk_mutate_job_selector'
require 'sem4r/bulk_mutate_job/bulk_mutate_job'

#
# campaign
#
require 'sem4r/campaign/campaign'


#
# targeting_idea
#
require 'sem4r/targeting_idea/targeting_idea'
require 'sem4r/targeting_idea/targeting_idea_selector'

#
# v13_account
#
require 'sem4r/v13_account/billing_address'

#
# v13_report
#
require 'sem4r/v13_report/report'
require 'sem4r/v13_report/report_job'

module Sem4r
  class Adwords

    #
    # new( "sandbox", {:email=>"..."} )
    # new( {:environment=>"...", email => "..." } )
    # new( "sandbox" )
    # new()
    #  sandbox default
    def initialize( config_name = "sandbox", config = nil )
      if not config.nil?
        @config_name = config_name.to_s
        @config = config.stringify_keys
        @config["environment"] = @config_name
      elsif config_name.respond_to?(:keys)
        @config = config_name.stringify_keys
        @config_name = @config["environment"]
      else
        @config_name = config_name
        @config = nil
      end
      @logger = nil
    end

    ##########################################################################
    # public methods

    def self.sandbox( config = nil )
      new( "sandbox", config )
    end

    def self.production( config = nil )
      new( "production", config )
    end

    def dump_soap_options( dump_options )
      @dump_soap_options = dump_options
      @connector.dump_soap_options( dump_options ) if @connector
    end

    def logger= logger
      @logger= logger
      @connector.logger= logger if @connector
    end

    def account
      deferred_initialize unless @initialized
      @account
    end

    #    def accounts
    #      deferred_initialize unless @initialized
    #      @accounts
    #    end

    def p_counters
      #      @counters.each { |k,v|
      #        puts "#{k} => #{v}"
      #      }
      operations = @counters[:operations]
      units = @counters[:units]
      response_time = @counters[:response_time]
      puts "#{units} unit spent for #{operations} operations in #{response_time}ms"
    end

    ##########################################################################
    # methods only for internal use

    attr_reader :service

    #
    # TODO: credentials are necessary because you can use more then account/credentials
    #       at the same time
    #
    def add_counters( credentials, counters )
      counters.each_pair { |k,v|
        @counters[k] ||= 0
        @counters[k] += v
      }
    end

    private

    def deferred_initialize
      @initialized = true

      @connector = SoapConnector.new
      @connector.dump_soap_options(@dump_soap_options) if @dump_soap_options
      @connector.logger=(@logger) if @logger

      unless @config
        @config = load_config(@config_name)
      end
      @config.stringify_keys!
      @config.assert_valid_keys("environment", "email", "password", "developer_token")
      @config.assert_check_keys("email", "password", "developer_token")

      @credentials = Credentials.new(
        :environment         => @config["environment"] || @config_name,
        :email               => @config["email"],
        :password            => @config["password"],
        :useragent           => "Sem4r Adwords Ruby Client Library (http://github.com/gf/sem4r)",
        :developer_token     => @config["developer_token"]
      )
      @credentials.connector = @connector

      @service = Service.new(@connector)
      # @accounts = @credentials.map { |cred| Account.new( self, cred ) }
      @account  = Account.new( self, @credentials )
      @counters = {
        :operations => 0,
        :response_time => 0,
        :units => 0
      }
    end

    def load_config(config_name)
      yaml = YAML::load( get_config_file )
      config  = yaml['google_adwords'][config_name.to_s]
      config
    end

    def get_config_file
      config_filename = "sem4r.yml"

      # try current directory
      if File.exists?( config_filename)
        f = File.open( config_filename )
        puts "Loaded profiles from #{config_filepath}"
      end
      # try ~/.sem4r/sem4r.yml
      unless f
        # require 'etc'
        # homedir = Etc.getpwuid.dir
        homedir = ENV['HOME']
        config_filepath = File.join( homedir, ".sem4r", config_filename)
        if File.exists?( config_filepath )
          f = File.open( config_filepath )
          puts "Loaded profiles from #{config_filepath}"
        end
      end

      # try <homesem4r>/config/sem4r
      unless f
        config_filepath =  File.expand_path( File.join( File.dirname( __FILE__ ), "..", "..", "config", config_filename ) )
        if File.exists?( config_filepath )
          f = File.open( config_filepath )
          puts "Loaded profiles from #{config_filepath}"
        end
      end

      unless f
        raise Sem4rError, "config file 'sem4r' not found"
      end
      f
    end

  end

end
