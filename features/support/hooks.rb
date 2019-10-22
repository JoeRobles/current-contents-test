require 'watir'

Before do
  @browser = Watir::Browser.new( :chrome, {:chromeOptions => {:args => ['--headless', '--window-size=1200x600']}})

end

After do
  @browser.close
end