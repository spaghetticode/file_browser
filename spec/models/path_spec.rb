require 'spec_helper'

module FsBrowser
  describe Path do
    let(:name) { fixtures_filesystem_path }
    let(:base) { name }

    subject { Path.new(name) }

    before { Path.base = base }

    it { should respond_to :file_list }
    it { should respond_to :pathname }
    it { should respond_to :entries }
    it { should respond_to :base }

    it 'has the root directory as default constant base path' do
      Path::BASE.should == '/'
    end

    context 'when base is set' do
      before { Path.base = name }

      it '::base returns the expected value' do
        Path.base.should == name
      end

      it 'base value is available also on instances' do
        subject.base.should == name
      end
    end

    context 'when base is not set' do
      before { Path.base = nil }

      it { Path.base.should == Path::BASE }
    end

    describe '::name_from_params' do
      context 'when params[:id] is empty' do
        it 'is the base path name' do
          params = {:id => ''}
          Path.name_from_params(params).should == Path.base
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

    describe '#validate' do
      context 'when the path name is above the base path' do
        before do
          subject.instance_variable_set '@pathname', Pathname.new('/')
        end

        it 'raises error' do
          expect { subject.validate }.to raise_error(FsBrowser::Path::ParentError)
        end
      end
    end

    context 'when a directory exists under the path' do
      let(:entry_path) { File.join(name, 'folder') }

      describe '#file_list' do
        context 'when name is not root' do
          before { subject.stub(:root? => false) }

          it 'parent dir is included in the list' do
            subject.file_list.should include('..')
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
          dir = subject.entries.detect { |e| e.path == entry_path }
          dir.ftype.should == 'directory'
        end
      end

      it 'represents the name and entries in json format' do
        subject.as_json.keys.should =~ %w[name entries]
      end
    end
  end
end