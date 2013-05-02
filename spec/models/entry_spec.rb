require 'spec_helper'

module FileBrowser
  describe Entry do
    let(:root)       { 'root' }
    let(:path)       { stub(:name => root) }
    let(:entry_name) { File.join root, 'somedir' }
    subject { Entry.new(entry_name, path) }

    before { create_dir entry_name }

    it { subject.should respond_to(:path) }
    it { subject.should respond_to(:type) }
    it { subject.type.should == FileBrowser::Entry::DIRECTORY }

    it 'has only file and directory types' do
      Entry::TYPES.should == [Entry::DIRECTORY, Entry::FILE]
    end

    it 'represents the name, path and type in json format' do
      json_hash = {:name => 'root/somedir', :type => 'directory', :parent_name => 'root'}.stringify_keys!
      subject.as_json.should == json_hash
    end
  end
end