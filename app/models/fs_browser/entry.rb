module FsBrowser
  class Entry
    attr_reader :name, :ext, :path, :pathname

    delegate :file?, :directory?, :ftype, :to => :pathname

    def initialize(path)
      @path = path
      @pathname = Pathname.new(path)
      @name = @pathname.basename.to_s
      @ext  = @pathname.extname.downcase
    end

    def as_json(opts={})
      {'name' => name, 'type' => ftype, 'path' => path, 'ext' => ext}
    end
  end
end
