module SpecHelpers
  def create_dir(dirname)
    FileUtils.mkdir_p dirname
  end

  def create_child_dir(dirname)
    FileUtils.mkdir_p File.join(path, dirname)
  end
end