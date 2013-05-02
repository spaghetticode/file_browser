module FileBrowser
  class Entry
    FILE      = 'file'
    DIRECTORY = 'directory'
    TYPES     = [DIRECTORY, FILE]

    attr_reader :name, :type, :ext

    def initialize(name)
      @name = name
      @type = get_type
      @ext  = get_ext
    end

    TYPES.each do |method_name|
      define_method "#{method_name}?" do
        self.class.const_get("#{method_name}".upcase) == type
      end
    end

    def as_json(opts={})
      {'name' => name, 'type' => type}
    end

    private


    def get_type
      TYPES.detect { |type| File.send("#{type}?", name) }
    end

    def get_ext
      File.extname(name)[1..-1] if file?
    end
  end
end
