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
        @name = name
        @pathname = Pathname.new full_path(name)
        validate
        @entries = get_entries
    end

    def get_entries
      file_list.map do |entry_pathname|
        Entry.new(entry_pathname)
      end
    end

    def validate
      relative = realpath.relative_path_from(root)
      raise raise ParentError if relative.to_s.include? '..'
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
      Pathname.new(self.class.root)
    end

    def full_path(name)
      File.join root, name
    end

    def realpath
      @realpath ||= begin
        pathname.realpath
      rescue Errno::ENOENT
        raise NotFoundError
      end
    end
  end
end
