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

    describe '#to_json' do
      it { subject.should respond_to(:to_json) }
      it { subject.to_json.should be_a(Hash) }
    end
  end
end