module SpecHelpers
  def create_dir(dirname)
    FileUtils.mkdir_p dirname
  end

  def create_file(filename)
    name = File.basename(filename)
    dir  = filename[0..filename.rindex(name)]
    create_dir(dir)
    FileUtils.touch(filename)
  end

  def double_click(text)
    element = page.find(:xpath,"//a[contains(.,'#{text}')]")
    page.driver.browser.mouse.double_click(element.native)
  end
end