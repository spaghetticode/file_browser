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
end