# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sem4r}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Giovanni Ferro"]
  s.date = %q{2009-11-21}
  s.description = %q{ruby library to access google adwords api}
  s.email = %q{giovanni.ferro@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "examples/create.rb",
     "examples/example_helper.rb",
     "examples/get_account.rb",
     "examples/get_info.rb",
     "examples/list_ad.rb",
     "examples/list_keywords.rb",
     "examples/prune.rb",
     "lib/sem4r.rb",
     "lib/sem4r/adwords.rb",
     "lib/sem4r/api_counters.rb",
     "lib/sem4r/credentials.rb",
     "lib/sem4r/enum.rb",
     "lib/sem4r/model/account.rb",
     "lib/sem4r/model/adgroup.rb",
     "lib/sem4r/model/adgroup_ad.rb",
     "lib/sem4r/model/adgroup_bid.rb",
     "lib/sem4r/model/base.rb",
     "lib/sem4r/model/campaign.rb",
     "lib/sem4r/model/criterion.rb",
     "lib/sem4r/model/report.rb",
     "lib/sem4r/model/report_job.rb",
     "lib/sem4r/services/account_service.rb",
     "lib/sem4r/services/ad_extension_override_service.rb",
     "lib/sem4r/services/adgroup_ad_service.rb",
     "lib/sem4r/services/adgroup_criterion_service.rb",
     "lib/sem4r/services/adgroup_service.rb",
     "lib/sem4r/services/campaign_criterion_service.rb",
     "lib/sem4r/services/campaign_service.rb",
     "lib/sem4r/services/campaign_target_service.rb",
     "lib/sem4r/services/define_call.rb",
     "lib/sem4r/services/info_service.rb",
     "lib/sem4r/services/report_service.rb",
     "lib/sem4r/services/service.rb",
     "lib/sem4r/services/soap_connector.rb",
     "lib/sem4r/services/soap_fault.rb",
     "lib/sem4r/services/soap_message_v13.rb",
     "lib/sem4r/services/soap_message_v2009.rb",
     "lib/sem4r/services/targeting_idea_service.rb",
     "lib/sem4r/services/traffic_estimator_service.rb",
     "sem4r.gemspec"
  ]
  s.homepage = %q{http://github.com/gf/sem4r}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{sem}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{library to access google adwords api}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<patron>, [">= 0"])
      s.add_development_dependency(%q<spec>, [">= 0"])
    else
      s.add_dependency(%q<patron>, [">= 0"])
      s.add_dependency(%q<spec>, [">= 0"])
    end
  else
    s.add_dependency(%q<patron>, [">= 0"])
    s.add_dependency(%q<spec>, [">= 0"])
  end
end

