# frozen_string_literal: true

require File.expand_path(File.dirname(__FILE__) + '/edgecase')
require 'selenium-webdriver'

class AboutDrivingBrowsers < Edgecase::Koan

  # Selenium WebDriver works with all of the major browsers, but
  # it needs to be able to find the underlying executable to work.
  # Let's see what happens in the (likely) case that you don't
  # already have the driver form PhantomJS (a headless JS capable
  # browser) installed.
  def test_selenium_throws_load_error_if_underlying_driver_is_missing
    driver_launched = false
    begin
      driver = Selenium::WebDriver.for :phantomjs
      driver.quit
      driver_launched = true
    rescue LoadError
    end
    assert_equal false, driver_launched
  end

  def test_selenium_throws_exception_if_unknown_driver_invoked
    driver_launched = false
    begin
      driver = Selenium::WebDriver.for :not_a_driver
      driver.quit
      driver_launched = true
    rescue StandardError => ex
      assert_equal true, ex.is_a?(ArgumentError)
    end
    assert_equal false, driver_launched
  end

  def ensure_driver(browser)
    begin
      driver = Selenium::WebDriver.for browser
    rescue LoadError
      flunk "You need to have the #{browser} driver installed"
    end
  end

  # Before this can pass, you'll need to have geckodriver installed
  # and available on your PATH. If you are on a Mac and are using
  # Homebrew, you can:
  #
  #     brew install geckodriver
  #
  # If you are on Windows and are using chocolatey, you can:
  #
  #     choco install geckodriver
  #
  # If neither of those work, find documentation at:
  #
  #     https://github.com/mozilla/geckodriver
  def test_selenium_can_drive_firefox
    assert_nothing_raised do
      driver = ensure_driver(:firefox)
      driver.quit      
    end
  end

  # Before this can pass, you'll need to have chromedriver installed
  # and available on your PATH. If you are on a Mac and are using
  # Homebrew, you can:
  #
  #     brew install chromedriver
  #
  # If you are on Windows and are using chocolatey, you can:
  #
  #     choco install chromedriver
  #
  # If neither of those work, find documentation at:
  #
  #     https://chromedriver.chromium.org/
  def test_selenium_can_drive_chrome
    assert_nothing_raised do
      driver = ensure_driver(:chrome)
      driver.quit      
    end
  end

  # The above examples show how you can drive a browser through selenium
  # webdriver with all of the window chrome showing. But what about in
  # a Continuous Integration environment where you don't want that? Enter
  # headless mode.
  def test_selenium_can_drive_firefox_headless
    options = Selenium::WebDriver::Firefox::Options.new
    options.add_argument('--headless')
    driver = Selenium::WebDriver.for :firefox, options: options
    driver.quit
  end

  def test_selenium_can_drive_chrome_headless
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    driver = Selenium::WebDriver.for :chrome, options: options
    driver.quit
  end

  # The remainder of the Koans will use Chrome's driver. In your
  # projects that use webdriver, you can choose from the supported
  # list. See:
  #
  #   https://www.rubydoc.info/gems/selenium-webdriver/Selenium/WebDriver
  #
  # for more info on which drivers are supported.
end

