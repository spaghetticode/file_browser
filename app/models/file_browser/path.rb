module FileBrowser
  class Path
    class NotFoundError < Exception; end

    attr_reader :name

    def initialize(name)
      @name = name
      validate_name
    end

    def entries
      Dir.glob("#{name}/*").map do |entry_name|
        Entry.new(entry_name, self)
      end
    end

    def validate_name
      raise NotFoundError unless File.exists?(name)
    end

    def full_entry_name(entry_name)
      File.join name, entry_name
    end

    def entry_type(entry_name)
      Entry.type(entry_name)
    end
  end
end
