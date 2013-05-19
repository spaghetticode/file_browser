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
        subject.root.to_s.should == Path.root
      end

      it '#root is a pathname' do
        subject.root.should be_a Pathname
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

    describe '#full_path' do
      it 'always includes root' do
        subject.full_path('/something').should == "#{subject.root}/something"
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

      context 'when trying to access a root parent dir' do
        it 'raise an error' do
          expect { Path.new('folder/../..')}.to raise_error Path::ParentError
        end
      end

      describe '#children' do
        it 'delegates to realpath' do
          subject.realpath.should_receive(:children)
          subject.children
        end

        context 'when user has no read access to folder' do
          it 'returns an empty array' do
            begin
              File.chmod(0333, fixtures_filesystem_path)
              subject.children.should == []
            ensure
              File.chmod(0755, fixtures_filesystem_path)
            end
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