require 'watir'

Before do
  @browser = Watir::Browser.new( :chrome, {:chromeOptions => {:args => %w[--headless, no-sandbox, no-gui']}})

end

After do
  @browser.close
end