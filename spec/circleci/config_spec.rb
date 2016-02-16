require 'spec_helper'

describe CircleCi::Config do
  let(:config) { CircleCi::Config.new }

  describe 'initialize' do
    it 'sets default host' do
      config.host.should eql CircleCi::Config::DEFAULT_HOST
    end

    it 'sets default port' do
      config.port.should eql 80
    end
  end
end
