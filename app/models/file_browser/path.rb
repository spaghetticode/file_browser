module FileBrowser
  class Path
    class NotFoundError < Exception; end
    BASE = '/'

    cattr_accessor :base

    def self.base
      @@base || BASE
    end

    attr_reader :name, :entries

    def self.name_from_params(params)
      name = params[:id]
      name == 'root' ? base : name
    end

    def initialize(name)
      validate(name)
      @name    = name
      @entries = get_entries
    end

    def get_entries
      file_list.map do |entry_name|
        Entry.new(entry_name)
      end
    end

    def file_list
      list = Dir.glob("#{name}/*")
      list.unshift '..' unless root?
      list
    end

    def root?
      name == base
    end

    def validate(name)
      raise NotFoundError unless File.exists?(name)
    end
  end
end
