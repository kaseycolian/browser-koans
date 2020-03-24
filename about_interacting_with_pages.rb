# frozen_string_literal: true

require File.expand_path(File.dirname(__FILE__) + '/edgecase')
require File.expand_path(File.dirname(__FILE__) + '/browser')

require 'selenium-webdriver'

class AboutInteractingWithPages < Edgecase::Koan

  def test_fill_in_text_input_fields
    on_browserkoans_test_page do |driver|
      text_field = driver.find_element id: 'textentry'
      assert_equal '', text_field.attribute('value')
      text_field.send_keys 'Hello World'
      assert_equal __, text_field.attribute('value')
    end
  end

  def test_toggle_a_checkbox
    on_browserkoans_test_page do |driver|
      checkbox = driver.find_element id: 'option-1'
      assert_nil checkbox.attribute('checked')
      checkbox.click
      assert_not_nil checkbox.attribute('checked')
    end
  end

  def test_fill_out_and_submit_entire_form
    on_browserkoans_test_page do |driver|
      checkbox = driver.find_element id: 'option-1'
      text_field = driver.find_element id: 'textentry'
      submit = driver.find_element id: 'form-submit'
      checkbox_result = driver.find_element id: 'result-checkboxes'
      text_result = driver.find_element id: 'result-text'

      assert_equal "No options chosen", checkbox_result.text
      assert_equal "Nothing entered", text_result.text

      text_field.send_keys 'Hello World'
      checkbox.click
      submit.click

      assert_equal __, checkbox_result.text
      assert_equal __, text_result.text
    end
  end

  def test_invoke_existing_javascript_function
    on_browserkoans_test_page do |driver|
      evidence = driver.find_element id: 'load-me-dynamically'
      before_invocation = evidence.text
      driver.execute_script "loadItDynamically();"
      after_invocation = evidence.text
      assert_equal __, before_invocation != after_invocation 
    end
  end
end
