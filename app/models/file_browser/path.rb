module FileBrowser
  class Path
    class NotFoundError < Exception; end
    BASE = '/'

    attr_reader :name, :entries

    def self.name_from_params(params)
      name = params[:id]
      name == 'root' ? Path::BASE : name
    end

    def initialize(name)
      raise NotFoundError unless File.exists?(name)
      @name    = name
      @entries = get_entries
    end

    def get_entries
      Dir.glob("#{name}/*").map do |entry_name|
        Entry.new(entry_name)
      end
    end
  end
end
