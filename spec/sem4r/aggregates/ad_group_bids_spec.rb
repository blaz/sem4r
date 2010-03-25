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

describe AdGroupBids do
  include Sem4rSpecHelper

  describe ManualCPCAdGroupBids do

    it "should accept accessor" do
      bids = ManualCPCAdGroupBids.new
      bids.keyword_max_cpc 20000000
      bids.site_max_cpc 30000000
      bids.keyword_max_cpc.should == 20000000
      bids.site_max_cpc.should    == 30000000
    end

    it "should accept a block" do
      bids = ManualCPCAdGroupBids.new do
        keyword_max_cpc 20000000
        site_max_cpc 30000000
      end

      bids.keyword_max_cpc.should == 20000000
      bids.site_max_cpc.should    == 30000000
    end

    it "should build xml (input for google)" do
      bids = ManualCPCAdGroupBids.new
      bids.keyword_max_cpc 20000000
      bids.site_max_cpc 30000000
      expected_xml = read_model("//bids", "services", "ad_group_service", "mutate_add-req.xml")
      bids.to_xml.should xml_equivalent(expected_xml)
    end

    it "should parse xml (produced by google)" do
      el = read_model("//bids", "services", "ad_group_service", "get-res.xml")
      bids = AdGroupBids.from_element(el)
      bids.keyword_max_cpc.should == 20000000
      bids.site_max_cpc.should    == 30000000
    end
  
  end

end
