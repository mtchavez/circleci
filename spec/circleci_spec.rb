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

end
