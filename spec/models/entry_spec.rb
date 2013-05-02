require 'spec_helper'

module FileBrowser
  describe Entry do
    let(:root) { 'root' }
    let(:name) { File.join root, 'somedir' }
    subject { Entry.new(name) }

    before { create_dir name }

    it { subject.should respond_to :name }
    it { subject.should respond_to :type }
    it { subject.type.should == Entry::DIRECTORY }

    it 'has only file and directory types' do
      Entry::TYPES.should == [Entry::DIRECTORY, Entry::FILE]
    end

    it 'represents the name, path and type in json format' do
      json_hash = {:name => name, :type => Entry::DIRECTORY}.stringify_keys!
      subject.as_json.should == json_hash
    end
  end
end