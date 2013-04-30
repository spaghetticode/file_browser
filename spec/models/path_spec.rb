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

      it 'includes the parent directory' do
        subject.entries.should include('..')
      end

      it 'doesnt include the current directory' do
        subject.entries.should_not include('.')
      end

      it 'finds directories under the path' do
        dirname = 'somedir'
        create_child_dir dirname
        subject.entries.should include dirname
      end
    end
  end
end