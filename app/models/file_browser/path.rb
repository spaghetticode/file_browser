module FileBrowser
  class Path
    class NotFoundError < Exception
    end

    attr_reader :name

    def initialize(name)
      @name = name
      validate_name
    end

    def entries
      Dir.entries(name).reject {|v| v == '.'}
    end

    def validate_name
      raise NotFoundError unless File.exists?(name)
    end
  end
end
