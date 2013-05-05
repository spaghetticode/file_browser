require 'spec_helper'

module FsBrowser
  describe Entry do
    include FakeFS::SpecHelpers

    let(:ext)       { '.jpg' }
    let(:root)      { 'root' }
    let(:dir_name)  { 'somedir' }
    let(:file_name) { "picture#{ext}" }
    let(:dir_path)  { File.join root, dir_name }
    let(:file_path) { File.join root, file_name }

    subject         { Entry.new(dir_path) }

    before do
      create_dir  dir_path
      create_file file_path
    end

    it { subject.should respond_to :name }
    it { subject.should respond_to :type }
    it { subject.should respond_to :ext }
    it { subject.should respond_to :file? }
    it { subject.should respond_to :directory? }

    it 'has only file and directory types' do
      Entry::TYPES.should == [Entry::DIRECTORY, Entry::FILE]
    end

    it 'represents the name, path, type and ext in json format' do
      json_hash = {
        :path => dir_path,
        :type => Entry::DIRECTORY,
        :name => dir_name,
        :ext  => nil
      }.stringify_keys!
      subject.as_json.should == json_hash
    end

    context 'when directory' do
      it { subject.ext.should_not be_present }
      it { subject.type.should == Entry::DIRECTORY }
      it { subject.should be_directory }
      it { subject.should_not be_file }
      it { subject.name.should == dir_name }
    end

    context 'when file' do
      subject { Entry.new(file_path) }

      it { subject.should be_file }
      it { subject.should_not be_directory }
      it { subject.type.should == Entry::FILE }
      it { subject.ext.should == ext }
    end
  end
end