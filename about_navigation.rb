# frozen_string_literal: true

require File.expand_path(File.dirname(__FILE__) + '/edgecase')
require File.expand_path(File.dirname(__FILE__) + '/browser')

require 'selenium-webdriver'

class AboutNavigation < Edgecase::Koan

  GOOGLE = 'https://www.google.com/'
  MICROSOFT = 'https://www.microsoft.com/en-us/'

  def test_navigating_via_the_driver_navigation_object
    selenium do |driver|
      driver.navigate.to GOOGLE
    end
  end

  def test_navigating_via_get
    selenium do |driver|
        driver.get MICROSOFT
    end
  end

  def test_getting_the_current_url
    selenium do |driver|
      driver.get GOOGLE
      assert_equal "https://www.google.com/", driver.current_url
    end
  end

  def test_refreshing_the_page_leaves_you_in_the_same_place
    selenium do |driver|
      driver.get GOOGLE
      driver.navigate.refresh
      assert_equal "https://www.google.com/", driver.current_url
    end
  end

  def test_webdriver_can_navigate_to_multiple_pages
    selenium do |driver|
      driver.get GOOGLE
      driver.get MICROSOFT
      assert_equal "https://www.microsoft.com/en-us/", driver.current_url
    end
  end

  def test_webdriver_can_navigate_backwards_in_history
    selenium do |driver|
      driver.get GOOGLE
      driver.get MICROSOFT
      driver.navigate.back
      assert_equal "https://www.google.com/", driver.current_url
    end
  end

  def test_webdriver_can_navigate_forward_in_history
    selenium do |driver|
      driver.get GOOGLE
      driver.get MICROSOFT
      driver.navigate.back
      driver.navigate.forward
      assert_equal "https://www.microsoft.com/en-us/", driver.current_url
    end
  end
end
