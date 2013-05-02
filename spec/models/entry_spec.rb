require 'spec_helper'

module FileBrowser
  describe Entry do
    let(:root) { 'root' }
    let(:name) { File.join root, 'somedir' }
    subject { Entry.new(name) }

    before { create_dir name }

    it { subject.should respond_to :name }
    it { subject.should respond_to :type }
    it { subject.should respond_to :ext }
    it { subject.should respond_to :file? }
    it { subject.should respond_to :directory? }

    it { subject.type.should == Entry::DIRECTORY }
    it { subject.should be_directory }
    it { subject.should_not be_file }

    it 'has only file and directory types' do
      Entry::TYPES.should == [Entry::DIRECTORY, Entry::FILE]
    end



    it 'represents the name, path and type in json format' do
      json_hash = {:name => name, :type => Entry::DIRECTORY}.stringify_keys!
      subject.as_json.should == json_hash
    end
  end
end