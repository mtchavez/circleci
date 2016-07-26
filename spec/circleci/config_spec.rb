# frozen_string_literal: true
require 'spec_helper'

RSpec.describe CircleCi::Config do
  let(:test_host) { 'https://mycircle.com:1234' }

  describe 'initialize' do
    it { expect(subject.host).to eql described_class::DEFAULT_HOST }
    it { expect(subject.version).to eql described_class::DEFAULT_VERSION }
    it { expect(subject.port).to eql described_class::DEFAULT_PORT }
  end

  describe 'uri' do
    it 'includes port if not 80' do
      subject.port = 1234
      expect(subject.uri).to match(/:1234/)
    end

    it 'does not include default port' do
      expect(subject.uri).not_to match(/:80/)
      host_and_port = CircleCi::Config::DEFAULT_HOST + ':80'
      expect(subject.uri).not_to match(host_and_port)
    end

    it 'includes port if set on host' do
      subject.host = test_host
      expect(subject.uri).to match(test_host)
    end
  end
end
