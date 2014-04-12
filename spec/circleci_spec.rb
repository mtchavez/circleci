require 'spec_helper'

describe CircleCi do

  context 'configuration' do

    it 'takes block to set config' do
      CircleCi.configure do |config|
        config.token = 'test-key'
      end
      CircleCi.config.token.should eql 'test-key'
    end

    it 'can be accessed after being set' do
      CircleCi.configure do |config|
        config.token = 'test-key'
      end
      CircleCi.config.token.should eql 'test-key'
      CircleCi.config.token = 'new-key'
      CircleCi.config.token.should eql 'new-key'
    end

  end

  describe 'organization', vcr: { cassette_name: 'organization', record: :none } do

    subject { CircleCi.organization(ENV['ORGANIZATION'] || 'orga-name') }
    let(:body) { subject.body }

    it { should be_an_instance_of(CircleCi::Response) }
    it { should be_success }

    it 'returns a list of recent builds' do
      expect(body).to be_an_instance_of(Array)
      expect(body.size).to eq(2)
      expect(body.first).to have_key('username')
      expect(body.first).to have_key('reponame')
      expect(body.first).to have_key('vcs_url')
    end

  end

end
