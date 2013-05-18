module FsBrowser
  class Entry
    attr_reader :pathname, :name, :ext, :type

    delegate :file?, :directory?, :exist?, :realpath, :to => :pathname

    def initialize(pathname)
        @pathname = pathname
        @name = @pathname.basename.to_s
        @ext  = @pathname.extname.downcase
        @type = realpath.ftype if exist?
    end

    def as_json(opts={})
      {'name' => name, 'type' => type, 'ext' => ext}
    end
  end
end
