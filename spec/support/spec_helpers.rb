module SpecHelpers
  def create_dir(dirname)
    FileUtils.mkdir_p dirname
  end
end