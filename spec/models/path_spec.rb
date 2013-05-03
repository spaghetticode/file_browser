require 'spec_helper'

module FileBrowser
  describe Path do
    let(:name) { 'tempdir' }
    subject { Path.new(name) }

    before { create_dir name }

    it 'has the root directory as base path name' do
      Path::BASE.should == '/'
    end

    describe '::name_from_params' do
      context 'when params[:id] is root' do
        it 'is the base path name when params[:id] is root' do
          params = {:id => 'root'}
          Path.name_from_params(params).should == Path::BASE
        end
      end

      it 'is params[:id]' do
        params = {:id => name}
        Path.name_from_params(params).should == name
      end
    end

    it 'requires a name parameter' do
      expect { Path.new }.to raise_error(ArgumentError)
    end

    it 'requires an existing path' do
      expect { Path.new('bogus/path') }.to raise_error(Path::NotFoundError)
    end

    it { subject.should respond_to :entries }

    describe '#entries' do
      it { subject.entries.should be_an Array }

      it 'is a collection of entries' do
        subject.entries.should be_all { |e| Entry === e }
      end

      it 'finds directories under the path' do
        entry_path = File.join(name, 'somedir')
        create_dir entry_path
        subject.entries.map(&:path).should include entry_path
      end

      it 'correctly sets the type of entry' do

        entry_path = File.join(name, 'somedir')
        create_dir entry_path
        dir = subject.entries.detect { |e| e.path == entry_path }
        dir.type.should == Entry::DIRECTORY
      end
    end

    it 'represents the name and entries in json format' do
      json_hash = {:name => name, :entries => []}.stringify_keys!
      subject.as_json.should == json_hash
    end
  end
end