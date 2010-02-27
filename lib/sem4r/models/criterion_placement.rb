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

module Sem4r
  class CriterionPlacement < Criterion

    g_accessor :url

    def initialize(ad_group, url = nil, &block)
      super( ad_group )
      self.type = Placement
      self.url = url unless url.nil?
      if block_given?
        instance_eval(&block)
        # save
      end
    end

    def self.from_element( ad_group, el )
      new(ad_group) do
        @id      = el.elements["id"].text.strip.to_i
        url        el.elements["url"].text
      end
    end

    def self.create(ad_group, &block)
      new(ad_group, &block).save
    end

    def to_s
      "#{@id} #{@type} #{@url}"
    end

    def to_xml(tag)
      unless tag.class == Builder::XmlMarkup
        builder = Builder::XmlMarkup.new
        tag = builder.tag!(tag, "xsi:type" => "CriterionKeyword")
      end
      tag.criterion("xsi:type" => "#{type}") do |ad|
        ad.url        url
      end
      tag.to_s
    end
  end
end
