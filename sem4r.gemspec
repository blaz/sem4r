# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sem4r}
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Giovanni Ferro"]
  s.date = %q{2009-12-01}
  s.default_executable = %q{sem4r_report.rb}
  s.description = %q{Library to access google adwords api. Works with ruby 1.9 and ruby 1.8.
                         This is a ALPHA version don't use in production}
  s.email = %q{gf@sem4r.com}
  s.executables = ["sem4r_report.rb"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION.yml",
     "config/sem4r.example.yml",
     "examples/01_get_account.rb",
     "examples/02_get_info.rb",
     "examples/03_list_ad.rb",
     "examples/04_list_keywords.rb",
     "examples/05_request_report.rb",
     "examples/06_create_campaigns.rb",
     "examples/07_prune_empty_adgroup.rb",
     "examples/08_ad_params.rb",
     "examples/09_targeting_idea.rb",
     "examples/10_get_location.rb",
     "examples/example_helper.rb",
     "lib/my_active_support/core_ext/hash.rb",
     "lib/my_active_support/core_ext/hash/keys.rb",
     "lib/sem4r.rb",
     "lib/sem4r/adwords.rb",
     "lib/sem4r/aggregates/adgroup_bid.rb",
     "lib/sem4r/aggregates/billing_address.rb",
     "lib/sem4r/aggregates/targeting_idea_selector.rb",
     "lib/sem4r/api_counters.rb",
     "lib/sem4r/credentials.rb",
     "lib/sem4r/models/account.rb",
     "lib/sem4r/models/ad_param.rb",
     "lib/sem4r/models/adgroup.rb",
     "lib/sem4r/models/adgroup_ad.rb",
     "lib/sem4r/models/base.rb",
     "lib/sem4r/models/campaign.rb",
     "lib/sem4r/models/criterion.rb",
     "lib/sem4r/models/report.rb",
     "lib/sem4r/models/report_job.rb",
     "lib/sem4r/sem4r_error.rb",
     "lib/sem4r/services/account_service.rb",
     "lib/sem4r/services/ad_extension_override_service.rb",
     "lib/sem4r/services/ad_param_service.rb",
     "lib/sem4r/services/adgroup_ad_service.rb",
     "lib/sem4r/services/adgroup_criterion_service.rb",
     "lib/sem4r/services/adgroup_service.rb",
     "lib/sem4r/services/campaign_criterion_service.rb",
     "lib/sem4r/services/campaign_service.rb",
     "lib/sem4r/services/campaign_target_service.rb",
     "lib/sem4r/services/geo_location_service.rb",
     "lib/sem4r/services/info_service.rb",
     "lib/sem4r/services/report_service.rb",
     "lib/sem4r/services/service.rb",
     "lib/sem4r/services/soap_call.rb",
     "lib/sem4r/services/soap_connector.rb",
     "lib/sem4r/services/soap_error.rb",
     "lib/sem4r/services/soap_message_v13.rb",
     "lib/sem4r/services/soap_message_v2009.rb",
     "lib/sem4r/services/targeting_idea_service.rb",
     "lib/sem4r/services/traffic_estimator_service.rb",
     "lib/sem4r/soap_attributes.rb",
     "sem4r.gemspec",
     "spec/fixtures/sem4r.example.yml",
     "spec/fixtures/services/report_all.xml"
  ]
  s.homepage = %q{http://www.sem4r.com}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{sem}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Library to access google adwords api. Works with ruby 1.9 and ruby 1.8}
  s.test_files = [
    "spec/sem4r/services/report_service_spec.rb",
     "spec/sem4r/services/soap_message_v13_spec.rb",
     "spec/sem4r/credentials_spec.rb",
     "spec/sem4r/soap_attributes_spec.rb",
     "spec/sem4r/adwords_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<spec>, [">= 0"])
    else
      s.add_dependency(%q<spec>, [">= 0"])
    end
  else
    s.add_dependency(%q<spec>, [">= 0"])
  end
end

