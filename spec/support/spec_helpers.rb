module SpecHelpers
  def fixtures_filesystem_path
    Rails.root.join('../../spec/fixtures/filesystem').to_s
  end

  def double_click(text)
    element = page.find(:xpath,"//a[contains(.,'#{text}')]")
    page.driver.browser.mouse.double_click(element.native)
  end
end