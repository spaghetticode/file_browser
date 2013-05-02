require 'spec_helper'

module FileBrowser
  describe Path do
    let(:path) { 'tempdir' }
    subject { Path.new(path) }

    before { create_dir path }

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
        entry_name = File.join(path, 'somedir')
        create_dir entry_name
        subject.entries.map(&:name).should include entry_name
      end

      it 'correctly sets the type of entry' do

        entry_name = File.join(path, 'somedir')
        create_dir entry_name
        dir = subject.entries.detect { |e| e.name == entry_name }
        dir.type.should == 'directory'
      end
    end
  end
end