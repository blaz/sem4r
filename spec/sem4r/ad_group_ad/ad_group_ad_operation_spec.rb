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


describe AdGroupAdOperation do
  include Sem4rSpecHelper
  
  before(:each) do
    @adgroup = mock("adgroup").as_null_object
    @ad_operation = AdGroupAdOperation.new
  end

  it "should raise missing operand" do
    @ad_operation.operator "ADD"
    @ad_operation.operator.should == "ADD"
    lambda {
      @ad_operation.to_xml(nil)
    }.should raise_error(Sem4rError, "Missing Operand")
  end

  it "should produce xml" do
    @adgroup.should_receive(:id).and_return(3060284754)
    text_ad = AdGroupTextAd.new(@adgroup)
    text_ad.headline     = "Cruise to Mars Sector 1"
    text_ad.description1 = "Visit the Red Planet in style."
    text_ad.description2 = "Low-gravity fun for everyone!"
    text_ad.display_url  = "www.example.com"
    text_ad.url          = "http://www.example.com"
    @ad_operation.add text_ad

    expected_xml = read_model("//operations", "services", "bulk_mutate_job_service", "mutate-req.xml")
    @ad_operation.to_xml('operations').should xml_equivalent(expected_xml)
  end

end