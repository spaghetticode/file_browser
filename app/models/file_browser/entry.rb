module FileBrowser
  class Entry
    FILE      = 'file'
    DIRECTORY = 'directory'
    TYPES     = [DIRECTORY, FILE]

    attr_reader :name, :type

    def initialize(name)
      @name = name
      @type = find_type
    end

    def as_json(opts={})
      {'name' => name, 'type' => type}
    end

    private

    def find_type
      TYPES.detect { |type| File.send("#{type}?", name) }
    end
  end
end
