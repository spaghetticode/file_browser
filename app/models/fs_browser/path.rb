module FsBrowser
  class Path
    class NotFoundError < Exception; end
    class ParentError   < Exception; end

    BASE = '/'

    class << self
      attr_writer :base

      def base
        @base ||= BASE
      end
    end

    attr_reader :name, :entries, :pathname

    def self.name_from_params(params)
      name = params[:id]
      name == 'root' ? base : name
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
      name == base
    end

    def base
      self.class.base
    end

    def validate
      raise NotFoundError unless pathname.exist?
      full_name = pathname.realpath.to_s
      full_base = File.expand_path(base)
      raise ParentError unless full_name =~ /\A#{full_base}/
    end
  end
end
