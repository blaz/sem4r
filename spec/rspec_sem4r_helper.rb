# -*- coding: utf-8 -*-
# -------------------------------------------------------------------------
# Copyright (c) 2009-2010 Sem4r sem4ruby@gmail.com
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

# comparing xml is always a b-i-a-t-c-h in any testing environment.  here is a
# little snippet for ruby that, i think, it a good first pass at making it
# easier.  comment with your improvements please!
#
# http://drawohara.com/post/89110816/ruby-comparing-xml

module Sem4rSpecHelper

  require "stringio"
  def with_stdout_captured
    old_stdout = $stdout
    out = StringIO.new
    $stdout = out
    begin
      yield
    ensure
      $stdout = old_stdout
    end
    out.string
  end

  #############################################################################

  def read_xml(service, xml_file, *args)
    # xml_filepath  = File.join(File.dirname(__FILE__), "fixtures", *args)
    xml_filepath  = File.join(File.dirname(__FILE__), "sem4r", service, "fixtures", xml_file)
    unless File.exist?(xml_filepath)
      raise "file #{xml_filepath} not exists"
    end
    contents = File.open(xml_filepath).read
    contents.gsub!(/\b(ns\d:|xsi:|s:|soapenv:|env:|soap:)/, "")
    contents.gsub!(/xmlns=["'].*?['"]/, '')
    contents
  end

  def read_model(xpath, service, xml_file, *args, &blk)
    contents = read_xml(service, xml_file, *args)
    xml_document = Nokogiri::XML::Document.parse(contents)
    if xpath && blk
      el = xml_document.xpath(xpath).each do |node|
        yield node
      end
    elsif xpath
      el = xml_document.xpath(xpath).first
    else
      el = xml_document.root.children.to_a.first
    end
    if el.nil?
      raise "xml element not found '#{xpath}'"
    end
    el
  end

  def read_xml_document(service, xml_file, *args)
    contents = read_xml(service, xml_file, *args)
    Nokogiri::XML::Document.parse(contents)
  end

  def read_xml_document_with_rexml(service, xml_file, *args)
    contents = read_xml(service, xml_file, *args)
    REXML::Document.new(contents)
  end

end
