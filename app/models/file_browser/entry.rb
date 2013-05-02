module FileBrowser
  class Entry
    FILE      = 'file'
    DIRECTORY = 'directory'
    TYPES     = [DIRECTORY, FILE]

    attr_reader :name, :path, :type

    # TODO path is basically useless here; the parent_name attribute is probably useless too, so
    # the path object could be entirely removed from initialization params
    def initialize(name, path)
      @name = name
      @path = path
      @type = find_type
    end

    def parent_name
      path.name
    end

    def as_json(opts={})
      {'name' => name, 'type' => type, 'parent_name' => parent_name }
    end

    private

    def find_type
      TYPES.detect { |type| File.send("#{type}?", name) }
    end
  end
end
