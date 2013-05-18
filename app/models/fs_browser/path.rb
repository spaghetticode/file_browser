module FsBrowser
  class Path
    class NotFoundError < Exception; end
    class ParentError   < Exception; end

    ROOT = '/'

    class << self
      attr_writer :root

      def root
        @root ||= ROOT
      end
    end

    attr_reader :name, :entries, :pathname

    def self.name_from_params(params)
      name = params[:id]
      name.present? ? name : root
    end

    def initialize(name)
      @name = name
      @pathname = Pathname.new(name)
      validate
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

    def as_json(opts={})
      {'name' => name, 'entries' => entries}
    end

    def root?
      name == root
    end

    def root
      self.class.root
    end

    def validate
      raise NotFoundError unless pathname.exist?
      full_name = pathname.realpath.to_s
      full_root = File.expand_path(root)
      raise ParentError unless full_name =~ /\A#{full_root}/
    end
  end
end
