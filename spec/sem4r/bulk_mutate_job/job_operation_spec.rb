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

describe JobOperation do
  include Sem4rSpecHelper, AggregatesSpecHelper


  it "should produce xml" do
    @campaign = mock("campaign").as_null_object
    @campaign.stub(:id).and_return(100)

    @adgroup = mock("adgroup").as_null_object
    @adgroup.stub(:id).and_return(3060284754)

    bulk_mutate_job = create_bulk_mutate_job(@campaign, @adgroup)
    bulk_mutate_job.should_not be_empty

    job_operation = JobOperation.new
    job_operation.add(bulk_mutate_job)
    
    expected_xml = read_model("//operation", "services", "bulk_mutate_job_service", "mutate-req.xml")
    job_operation.to_xml('operation').should xml_equivalent(expected_xml)
  end

end