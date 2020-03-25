# frozen_string_literal: true

require File.expand_path(File.dirname(__FILE__) + '/edgecase')
require File.expand_path(File.dirname(__FILE__) + '/browser')

require 'selenium-webdriver'

class AboutExtractingPageElements < Edgecase::Koan

  def test_you_can_extract_the_page_title
    on_browserkoans_test_page do |driver|
      page_title = driver.title
      assert_match /Test Page | Browser Koans/, page_title
    end
  end

  def test_you_can_extract_the_page_source
    on_browserkoans_test_page do |driver|
      page_source = driver.page_source
      assert_match /utf-8/, page_source
    end
  end

  
  def test_you_can_get_the_contents_of_a_found_element
    on_browserkoans_test_page do |driver|
      paragraph_text = driver.find_element(id: 'mypara').text
      assert_match /This is a paragraph with an id of mypara/, paragraph_text
    end
  end
    
  def test_we_can_get_other_attributes_in_addition_to_text
    on_browserkoans_test_page do |driver|
      element = driver.find_element(css: ".p-with-link a")
      href = element.attribute("href")
      protocol = element.attribute("protocol")

      assert_equal "http://rubykoans.com/", href
      assert_equal "http:", protocol
    end
  end

end
