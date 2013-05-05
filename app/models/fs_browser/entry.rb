module FsBrowser
  class Entry
    FILE      = 'file'
    DIRECTORY = 'directory'
    TYPES     = [DIRECTORY, FILE]

    attr_reader :name, :type, :ext, :path

    def initialize(path)
      @path = path
      @name = get_name
      @type = get_type
      @ext  = get_ext
    end

    TYPES.each do |method_name|
      define_method "#{method_name}?" do
        self.class.const_get("#{method_name}".upcase) == type
      end
    end

    def as_json(opts={})
      {'name' => name, 'type' => type, 'path' => path, 'ext' => ext}
    end

    private

    def get_name
      File.basename(path)
    end

    def get_type
      TYPES.detect { |type| File.send("#{type}?", path) }
    end

    def get_ext
      File.extname(name).downcase if file?
    end
  end
end
