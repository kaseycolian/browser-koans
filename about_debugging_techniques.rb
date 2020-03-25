require File.expand_path(File.dirname(__FILE__) + '/edgecase')
require File.expand_path(File.dirname(__FILE__) + '/browser')

require 'selenium-webdriver'

class AboutDebuggingTechniques < Edgecase::Koan

  SCREENSHOT_FILE = File.expand_path(File.dirname(__FILE__) + '/screenshot.png')

  def test_capturing_a_screenshot
    begin
      File.delete(SCREENSHOT_FILE)
    rescue => exception 
    end
    assert_equal false, File.exist?(SCREENSHOT_FILE)
    
    on_browserkoans_test_page do |driver|
      driver.save_screenshot(SCREENSHOT_FILE)
      assert_equal true, File.exist?(SCREENSHOT_FILE)
    end
  end

end
