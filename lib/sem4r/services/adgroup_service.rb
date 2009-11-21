## -------------------------------------------------------------------
## Copyright (c) 2009 Sem4r giovanni.ferro@gmail.com
##
## Permission is hereby granted, free of charge, to any person obtaining
## a copy of this software and associated documentation files (the
## "Software"), to deal in the Software without restriction, including
## without limitation the rights to use, copy, modify, merge, publish,
## distribute, sublicense, and/or sell copies of the Software, and to
## permit persons to whom the Software is furnished to do so, subject to
## the following conditions:
##
## The above copyright notice and this permission notice shall be
## included in all copies or substantial portions of the Software.
##
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
## EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
## MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
## NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
## LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
## OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
## WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
## -------------------------------------------------------------------

module Sem4r
  class AdgroupService
    include DefineCall

    def initialize(connector)
      @connector = connector
      @service_namespace = "https://adwords.google.com/api/adwords/cm/v200909"
      @header_namespace = @service_namespace
      @service_url = "https://adwords-sandbox.google.com/api/adwords/cm/v200909/AdGroupService"
    end

    define_call_v2009 :all, :campaign_id
    define_call_v2009 :create, :xml
    define_call_v2009 :delete, :adgroup_id

    def _all(campaign_id)
      <<-EOFS
      <get xmlns="#{@service_namespace}">
        <selector>
          <campaignId>#{campaign_id}</campaignId>
        </selector>
      </get>
      EOFS
    end

    def _create( xml )
      <<-EOFS
      <mutate xmlns="#{@service_namespace}">
        <operations xsi:type="AdGroupOperation">
          <operator>ADD</operator>
          <operand>
            #{xml}
          </operand>
        </operations>
      </mutate>
      EOFS
    end

    def _delete( id )
      <<-EOFS
      <mutate xmlns="#{@service_namespace}">
        <operations xsi:type="AdGroupOperation">
          <operator>SET</operator>
          <operand>
            <id>#{id}</id>
            <status>DELETED</status>
          </operand>
        </operations>
      </mutate>
      EOFS

      #
      # raise  [OperatorError.OPERATOR_NOT_SUPPORTED @ operations[0]] 
      #

      #      <<-EOFS
      #      <mutate xmlns="#{@service_namespace}">
      #        <operations xsi:type="AdGroupOperation">
      #          <operator>REMOVE</operator>
      #          <operand>
      #            <id>#{id}</id>
      #          </operand>
      #        </operations>
      #      </mutate>
      #      EOFS
    end

  end
end
