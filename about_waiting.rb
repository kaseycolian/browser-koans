# frozen_string_literal: true

require File.expand_path(File.dirname(__FILE__) + '/edgecase')
require File.expand_path(File.dirname(__FILE__) + '/browser')

require 'selenium-webdriver'

class AboutWaiting < Edgecase::Koan

  # Many, if not most, web applications now use javascript to provide
  # a more dynamic experience. When extracting page elements, we need
  # to be mindful that we might have to wait for a change to occur before
  # we can reason about what is on the page.
  def test_webdriver_does_not_wait_fory_dynamic_page_changes_by_default
    on_browserkoans_test_page do |driver|
      volatile_text = -> { driver['delayed-text'].text }
      assert_equal __, volatile_text.call[/Loading/].nil?
      assert_equal __, volatile_text.call[/jQuery/].nil?
    end
  end

  def wait_for(timeout,&block)
    wait = Selenium::WebDriver::Wait.new(:timeout => timeout)
    wait.until { yield }
  end

  def test_wait_for_the_text_to_change
    saw_change = false
    on_browserkoans_test_page do |driver|
      volatile_text = -> { driver['delayed-text'].text }
      begin
        wait_for(10) { !volatile_text.call[/Loading/] }
        saw_change = true
      rescue Selenium::WebDriver::Error::TimeoutError => ex
      end
    end
    assert_equal __, saw_change
  end

  def test_wait_but_not_for_long_enough
    saw_change = false
    on_browserkoans_test_page do |driver|
      volatile_text = -> { driver['delayed-text'].text }
      assert_raise(__) do
        wait_for(1) { !volatile_text.call[/Loading/] }
        saw_change = true
      end
    end
    assert_equal __, saw_change
  end
end
