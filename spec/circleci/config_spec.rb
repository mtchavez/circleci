require 'spec_helper'

describe CircleCi::Config do
  let(:config) { CircleCi::Config.new }

  describe 'initialize' do
    it 'sets default host' do
      config.host.should eql CircleCi::Config::DEFAULT_HOST
    end

    it 'sets default version' do
      config.version.should eql CircleCi::Config::DEFAULT_VERSION
    end

    it 'sets default port' do
      config.port.should eql CircleCi::Config::DEFAULT_PORT
    end
  end

  describe 'uri' do
    it 'includes port if not 80' do
      config.port = 1234
      config.uri.should match(/:1234/)
    end

    it 'does not include default port' do
      config.uri.should_not match(/:80/)
      host_and_port = CircleCi::Config::DEFAULT_HOST + ':80'
      config.uri.should_not match(host_and_port)
    end

    it 'includes port if set on host' do
      test_host = 'https://mycircle.com:1234'
      config.host = test_host
      config.uri.should match(test_host)
    end
  end

  describe 'is port 80' do
    it 'returns true if default port' do
      config.should be_port_80
    end

    it 'returns false if not default port' do
      config.port = 1234
      config.should_not be_port_80
    end
  end

  describe 'host has port' do
    it 'returns true if host has port set' do
      test_host = 'https://mycircle.com:1234'
      config.host = test_host
      config.should be_host_has_port
    end

    it 'returns false if host does not have port set' do
      config.should_not be_host_has_port
    end
  end
end
