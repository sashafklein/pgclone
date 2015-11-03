require 'spec_helper'

describe Pgclone do
  it 'has a version number' do
    expect(Pgclone::VERSION).not_to be nil
  end

  describe 'configuration' do
    Pgclone.configure do |config|
      config.appname = 'app-name'
      config.owner = 'db-owner'
      config.local_db = 'db-name'
    end

    it "takes configuration block" do
      cloner = Pgclone::Restore.new

      expect( cloner.appname ).to eq 'app-name'
      expect( cloner.owner ).to eq 'db-owner'
      expect( cloner.local_db ).to eq 'db-name' 
      expect( cloner.file ).to eq 'latest.dump' # default
    end

    it "errors without configuration block or given options" do
      Pgclone.configure do |config|
        config.appname = nil
      end

      expect{
        cloner = Pgclone::Restore.new
      }.to raise_error "Missing required option: appname."

      expect{ 
        cloner = Pgclone::Restore.new({ appname: 'whatever' })
      }.not_to raise_error
    end
  end
end
