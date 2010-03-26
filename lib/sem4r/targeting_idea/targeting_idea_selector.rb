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

module Sem4r

  class RelatedToKeywordSearchParameter
    include SoapAttributes

    g_accessor :text
    g_accessor :match_type

    def initialize(&block)
      if block_given?
        block.arity < 1 ? instance_eval(&block) : block.call(self)
      end
    end

    def to_xml
      <<-EOS
          <s:searchParameters xsi:type="s:RelatedToKeywordSearchParameter">
            <s:keywords xsi:type="Keyword">
              <Criterion.Type>Keyword</Criterion.Type>
              <text>#{text}</text>
              <matchType>#{match_type}</matchType>
            </s:keywords>
          </s:searchParameters>
      EOS
    end
  end

  class ExcludedKeywordSearchParameter
    include SoapAttributes

    g_accessor :text
    g_accessor :match_type

    def initialize(&block)
      if block_given?
        block.arity < 1 ? instance_eval(&block) : block.call(self)
      end
    end

    def to_xml
      <<-EOS
          <s:searchParameters xsi:type="s:ExcludedKeywordSearchParameter">
            <s:keywords xsi:type="Keyword">
              <Criterion.Type>Keyword</Criterion.Type>
              <text>#{text}</text>
              <matchType>#{match_type}</matchType>
            </s:keywords>
          </s:searchParameters>
      EOS
    end
  end

  class KeywordMatchTypeSearchParameter
    include SoapAttributes

    g_set_accessor :match_type

    def initialize(&block)
      if block_given?
        block.arity < 1 ? instance_eval(&block) : block.call(self)
      end
    end

    def to_xml
      xml = ""
      xml << '<s:searchParameters xsi:type="s:KeywordMatchTypeSearchParameter">'
      match_types.each do |t|
        xml << "<s:keywordMatchTypes>#{t}</s:keywordMatchTypes>"
      end
      xml << '</s:searchParameters>'
    end
  end

  class TargetingIdeaSelector
    include SoapAttributes

    enum :IdeaTypes, [:KEYWORD, :PLACEMENT]
    enum :RequestTypes, [:IDEAS, :STATS]

    g_accessor :idea_type, { :values_in => :IdeaTypes }
    g_accessor :request_type

    def initialize(&block)
      @search_parameters = []
      instance_eval(&block) if block_given?
    end

    # TODO: synthetize following methods with metaprogramming
    def related_to_keyword_search_parameter(&block)
      @search_parameters << RelatedToKeywordSearchParameter.new(&block)
    end

    def excluded_keyword_search_parameter(&block)
      @search_parameters << ExcludedKeywordSearchParameter.new(&block)
    end

    def keyword_match_type_search_parameter(&block)
      @search_parameters << KeywordMatchTypeSearchParameter.new(&block)
    end

    def to_xml
      xml=<<-EOFS
       <s:selector>
          <s:ideaType>#{@idea_type}</s:ideaType>
          <s:requestType>#{@request_type}</s:requestType>
      EOFS

      xml += @search_parameters.collect{ |sp| sp.to_xml }.join()

      xml+=<<-EOFS
        <s:paging>
          <startIndex>0</startIndex>
          <numberResults>100</numberResults>
        </s:paging>
        </s:selector>
      EOFS
      xml

    end
    #      <n3:selector>
    #
    #        <n3:ideaType>KEYWORD</n3:ideaType>
    #        <n3:requestType>IDEAS</n3:requestType>
    #
    #
    #
    #
    #        <n3:paging xmlns:n6="https://adwords.google.com/api/adwords/cm/v200909">
    #          <n6:startIndex>0</n6:startIndex>
    #          <n6:numberResults>100</n6:numberResults>
    #        </n3:paging>
    #
    #      </n3:selector>
    #

    ##########################################################################

  end
end