module FsBrowser
  class Path
    class ParentError   < Exception; end
    class NotFoundError < Exception; end

    ROOT = '/'

    class << self
      def root
        @root || ROOT
      end

      def root=(value)
        raise NotFoundError unless File.exist?(value)
        @root = value
      end
    end

    attr_reader :name, :entries, :pathname

    def initialize(name)
      Dir.chdir root do
        @name = name
        @pathname = Pathname.new(name)
        validate
        @entries = get_entries
      end
    end

    def get_entries
      file_list.map do |entry_pathname|
        Entry.new(entry_pathname)
      end
    end

    def children
      realpath.children
    rescue Errno::EACCES
      []
    end

    def file_list
      list = children
      list.unshift Pathname.new('..') unless root?
      list
    end

    def as_json(opts={})
      {'name' => name, 'entries' => entries}
    end

    def root?
      name.empty?
    end

    def root
      self.class.root
    end

    def realpath
      @realpath ||= begin
        pathname.realpath
      rescue Errno::ENOENT
        raise NotFoundError
      end
    end

    def validate
      full_root = File.expand_path(root)
      raise ParentError unless realpath.to_s =~ /\A#{full_root}/
    end
  end
end
