module FileBrowser
  class Entry
    FILE      = 'file'
    DIRECTORY = 'directory'
    TYPES     = [DIRECTORY, FILE]

    attr_reader :name, :path, :type

    def initialize(name, path)
      @name = name
      @path = path
      @type = find_type
    end

    def parent_name
      path.name
    end

    def to_json
      {:name => name, :type => type, :parent_name => parent_name }
    end

    private

    def find_type
      TYPES.detect { |type| File.send("#{type}?", name) }
    end
  end
end
