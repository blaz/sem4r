# -------------------------------------------------------------------
# Copyright (c) 2009 Giovanni Ferro gf@sem4r.com
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

module Sem4r
  class Criterion < Base

    enum :Types,             [:Keyword, :Placement]
    enum :KeywordMatchTypes, [:EXACT, :BROAD, :PHRASE]
    
    attr_reader :id
    attr_reader :adgroup

    def initialize(adgroup, &block)
      super( adgroup.adwords, adgroup.credentials )
      @adgroup = adgroup
      if block_given?
        instance_eval(&block)
        save
      end
    end

    def to_s
      case type
      when KEYWORD
        "#{@id} #{@type} #{@text} #{@match_type}"
      when PLACEMENT
        "#{@id} #{@type} #{@url}"
      end
    end

    def to_xml
      case type
      when KEYWORD
        str= <<-EOFS
          <criterion xsi:type="#{type}">
            <text>#{text}</text>
            <matchType>#{match_type}</matchType>
          </criterion>
        EOFS
      when PLACEMENT
        str= <<-EOFS
          <criterion xsi:type="#{type}">
            <url>#{url}</url>
          </criterion>
        EOFS
      end
      str
    end

    ###########################################################################

    g_accessor :type
    g_accessor :text,       {:if_type => Keyword}
    g_accessor :match_type, {:if_type => Keyword}
    g_accessor :url,        {:if_type => Placement}

    ###########################################################################
    # <entries xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="BiddableAdGroupCriterion">
    #    <adGroupId>5000010567</adGroupId>
    #    <criterion xsi:type="Keyword">
    #        <id>10008027</id>
    #        <Criterion.Type>Keyword</Criterion.Type>
    #        <text>pippo</text>
    #        <matchType>BROAD</matchType>
    #    </criterion>
    #    <AdGroupCriterion.Type>BiddableAdGroupCriterion</AdGroupCriterion.Type>
    #    <userStatus>ACTIVE</userStatus>
    #    <systemServingStatus>ELIGIBLE</systemServingStatus>
    #    <approvalStatus>PENDING_REVIEW</approvalStatus>
    #    <bids xsi:type="ManualCPCAdGroupCriterionBids">
    #        <AdGroupCriterionBids.Type>ManualCPCAdGroupCriterionBids</AdGroupCriterionBids.Type>
    #        <maxCpc>
    #            <amount>
    #                <ComparableValue.Type>Money</ComparableValue.Type>
    #                <microAmount>10000000</microAmount>
    #            </amount>
    #        </maxCpc>
    #        <bidSource>ADGROUP</bidSource>
    #    </bids>
    #    <qualityInfo>
    #        <qualityScore>5</qualityScore>
    #    </qualityInfo>
    #    <stats>
    #        <network>SEARCH</network>
    #        <Stats.Type>Stats</Stats.Type>
    #    </stats>
    #</entries>

    def self.from_element( adgroup, el )
      new(adgroup) do
        
        @id      = el.elements["id"].text
        type       el.elements["Criterion.Type"].text

        case type
        when Keyword
          text       el.elements["text"].text
          match_type el.elements["matchType"].text

        when Placement
          url        el.elements["url"].text
        end
      end
    end

    def self.create(adgroup, &block)
      new(adgroup, &block).save
    end

    ############################################################################

    def save
      unless @id
        soap_message =
          service.adgroup_criterion.create(credentials, adgroup.id, to_xml)
        add_counters( soap_message.counters )
        rval = REXML::XPath.first( soap_message.response, "//mutateResponse/rval")
        id = REXML::XPath.match( rval, "value/criterion/id" ).first
        @id = id.text.strip
      end
      self
    end

    ############################################################################

    def ad_param(&block)
      save
      ad_param = AdParam.new(adgroup, self, &block)
      @ad_params ||= []
      @ad_params << ad_param
      ad_param
    end

  end
end
