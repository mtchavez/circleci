require 'spec_helper'

describe CircleCi::Http do

  context 'initialize' do

    it 'sets the proxy server' do
      config = double('Config', proxy: 'http://myproxy.com')
      RestClient.should_receive(:proxy=).with(config.proxy).once
      CircleCi::Http.new(config)
    end

  end

end
