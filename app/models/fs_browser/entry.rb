module FsBrowser
  class Entry
    attr_reader :name, :type, :ext, :path, :pathname

    delegate :file?, :directory?, :to => :pathname

    def initialize(path)
      @pathname = Pathname.new(path)
      @path = path
      @name = @pathname.basename.to_s
      @type = @pathname.ftype
      @ext  = @pathname.extname.downcase
    end

    def as_json(opts={})
      {'name' => name, 'type' => type, 'path' => path, 'ext' => ext}
    end
  end
end
