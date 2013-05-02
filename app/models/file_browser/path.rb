module FileBrowser
  class Path
    class NotFoundError < Exception; end
    BASE = '/'

    attr_reader :name

    def initialize(name)
      raise NotFoundError unless File.exists?(name)
      @name    = name
      @entries = entries
    end

    def entries
      Dir.glob("#{name}/*").map do |entry_name|
        Entry.new(entry_name)
      end
    end
  end
end
