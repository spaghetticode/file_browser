module FsBrowser
  class Entry
    attr_reader :name, :ext, :path, :pathname, :type

    delegate :file?, :directory?, :to => :pathname

    def initialize(path)
      @path = path
      @pathname = Pathname.new(path)
      @name = @pathname.basename.to_s
      @ext  = @pathname.extname.downcase
      @type = @pathname.ftype rescue Errno::EBADF # it happens in /dev/fd dir
    end

    def as_json(opts={})
      {'name' => name, 'type' => type, 'path' => path, 'ext' => ext}
    end
  end
end
