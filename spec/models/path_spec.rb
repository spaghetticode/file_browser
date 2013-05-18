require 'spec_helper'

module FsBrowser
  describe Path do
    let(:name) { '' }
    let(:root) { fixtures_filesystem_path }

    subject { Path.new(name) }

    before { Path.root = root }

    it { should respond_to :file_list }
    it { should respond_to :pathname }
    it { should respond_to :entries }
    it { should respond_to :root }

    it 'has the root directory as default constant root path' do
      Path::ROOT.should == '/'
    end

    context 'when root is set' do
      before { Path.root = root }

      it '::root returns the expected value' do
        Path.root.should == root
      end

      it 'root value is available also on instances' do
        subject.root.should == Path.root
      end
    end

    it 'requires an existing root' do
      expect { Path.root = '/bogus/path'}.to raise_error(Path::NotFoundError)
    end

    context 'when root is not set' do
      before { Path.instance_variable_set '@root', nil }

      it { Path.root.should == Path::ROOT }
    end

    it 'requires a name parameter' do
      expect { Path.new }.to raise_error(ArgumentError)
    end

    it 'requires an existing path' do
      expect { Path.new('bogus/path') }.to raise_error(Path::NotFoundError)
    end

    describe '#validate' do
      context 'when the path name is above the root path' do
        before do
          subject.instance_variable_set '@pathname', Pathname.new('/')
        end

        it 'raises error' do
          expect { subject.validate }.to raise_error(FsBrowser::Path::ParentError)
        end
      end
    end

    context 'when a directory exists under the path' do
      let(:entry_name) { 'folder' }

      describe '#file_list' do
        context 'when name is not root' do
          before { subject.stub(:root? => false) }

          it 'parent dir is included in the list' do
            subject.file_list.should include Pathname.new('..')
          end
        end

        context 'when name is root' do
          before { subject.stub(:root? => true) }

          it 'parent dir is not included' do
            subject.file_list.should_not include('..')
          end
        end
      end

      describe '#entries' do
        it { subject.entries.should be_an Array }

        it 'is a collection of entries' do
          subject.entries.should be_all { |e| Entry === e }
        end

        it 'correctly sets the type of entry' do
          dir = subject.entries.detect { |e| e.name == entry_name }
          dir.type.should == 'directory'
        end
      end

      it 'represents the name and entries in json format' do
        subject.as_json.keys.should =~ %w[name entries]
      end
    end
  end
end