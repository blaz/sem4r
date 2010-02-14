# -------------------------------------------------------------------------
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
# 
# -------------------------------------------------------------------------

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')


describe Account do

  include Sem4rSpecHelper

  before do
    services = stub("services")
    mock_service_account(services)
    mock_service_info(services)
    mock_service_campaign(services)
    # mock_service_ad_group_criterion(services)
    # @account = mock_account(services)
    @adwords = mock_adwords(services)
    @credentials = mock_credentials
  end

  describe "account management" do

    it "should retrieve info" do
      account = Account.new(@adwords, @credentials)
      account.currency_code.should == "EUR"
    end

    it "should retrieve cost" do
      account = Account.new(@adwords, @credentials)
      account.year_unit_cost("UNIT_COUNT").should == 100
    end

  end

  describe "campaign management" do

    it "should add an Campaign with method 'campaign' + block" do
      account = Account.new(@adwords, @credentials)
      account.campaign do
        name "campaign"
      end
      account.campaigns.length.should   ==  1
      campaign = account.campaigns.first
      campaign.id.should == 10
      campaign.name.should == "campaign"
    end

    it "should add an Campaign with method 'campaign' + param" do
      account = Account.new(@adwords, @credentials)
      account.campaign "campaign"
      
      account.campaigns.length.should   ==  1
      campaign = account.campaigns.first
      campaign.id.should == 10
      campaign.name.should == "campaign"
    end

  end

end
