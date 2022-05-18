# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CircleCi::Config do
  subject(:config) { described_class.new }

  let(:test_host)  { 'https://mycircle.com' }
  let(:test_port)  { 1234 }
  let(:proxy_user) { 'proxyuser' }
  let(:proxy_pass) { 'proxypass' }
  let(:proxy_port) { 6000 }
  let(:proxy_host) { 'https://circleproxy.org' }

  describe 'initialize' do
    it { expect(config.host).to eql described_class::DEFAULT_HOST }
    it { expect(config.version).to eql described_class::DEFAULT_VERSION }
    it { expect(config.port).to eql described_class::DEFAULT_PORT }
  end

  describe 'uri' do
    it 'includes port if not 80' do
      config.port = 1234
      expect(config.uri.port).to eql(config.port)
    end

    context 'when default port' do
      it 'is not used in uri' do
        host_and_port = "#{CircleCi::Config::DEFAULT_HOST}:80"
        expect(config.uri).not_to match(host_and_port)
      end
    end

    context 'when port is set on host' do
      let(:uri) { config.uri.to_s }

      before do
        config.host = test_host
        config.port = test_port
      end

      it 'includes port' do
        expect(uri).to match(/#{test_port}/)
      end
    end
  end

  describe 'proxy_userinfo' do
    context 'without user and password' do
      it 'is false' do
        expect(config).not_to be_proxy_userinfo
      end
    end

    context 'with user and password' do
      before do
        config.proxy_user = proxy_user
        config.proxy_pass = proxy_pass
      end

      it 'is true' do
        expect(config).to be_proxy_userinfo
      end
    end
  end

  describe 'proxy_to_port' do
    context 'when not set' do
      it 'defaults to 80' do
        expect(config.proxy_to_port).to eq(80)
      end
    end

    context 'when set' do
      before do
        config.proxy_port = proxy_port
      end

      it 'returns configured port' do
        expect(config.proxy_to_port).to eq(proxy_port)
      end
    end
  end

  describe 'proxy_uri' do
    context 'with proxy set to true' do
      before { config.proxy = true }

      describe 'no proxy host' do
        it 'returns nil' do
          expect(config.proxy_uri).to be_nil
        end
      end

      describe 'with proxy host' do
        let(:uri) { config.proxy_uri.to_s }

        before do
          config.proxy_host = proxy_host
        end

        it 'returns uri with proxy info' do
          expect(uri).to match(/#{config.proxy_to_port}/)
        end

        describe 'user info' do
          before do
            config.proxy_user = proxy_user
            config.proxy_pass = proxy_pass
          end

          it 'returns uri with proxy info' do
            expect(uri).to match("#{config.proxy_user}:#{config.proxy_pass}")
          end
        end
      end
    end

    context 'with proxy set to false' do
      it 'returns nil' do
        expect(config.proxy_uri).to be_nil
      end
    end
  end
end
