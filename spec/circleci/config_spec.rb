# frozen_string_literal: true
require 'spec_helper'

RSpec.describe CircleCi::Config do
  let(:test_host)  { 'https://mycircle.com' }
  let(:test_port)  { 1234 }
  let(:proxy_user) { 'proxyuser' }
  let(:proxy_pass) { 'proxypass' }
  let(:proxy_port) { 6000 }
  let(:proxy_host) { 'https://circleproxy.org' }

  describe 'initialize' do
    it { expect(subject.host).to eql described_class::DEFAULT_HOST }
    it { expect(subject.version).to eql described_class::DEFAULT_VERSION }
    it { expect(subject.port).to eql described_class::DEFAULT_PORT }
  end

  describe 'uri' do
    it 'includes port if not 80' do
      subject.port = 1234
      expect(subject.uri.port).to eql(subject.port)
    end

    it 'does not include default port' do
      expect(subject.uri).not_to match(/:80/)
      host_and_port = CircleCi::Config::DEFAULT_HOST + ':80'
      expect(subject.uri).not_to match(host_and_port)
    end

    it 'includes port if set on host' do
      subject.host = test_host
      subject.port = test_port
      uri = subject.uri.to_s
      expect(uri).to match(test_host)
      expect(uri).to match(/#{test_port}/)
    end
  end

  describe 'proxy_userinfo' do
    context 'without user and password' do
      it 'is false' do
        expect(subject).not_to be_proxy_userinfo
      end
    end

    context 'with user and password' do
      before do
        subject.proxy_user = proxy_user
        subject.proxy_pass = proxy_pass
      end

      it 'is true' do
        expect(subject).to be_proxy_userinfo
      end
    end
  end

  describe 'proxy_to_port' do
    context 'when not set' do
      it 'defaults to 80' do
        expect(subject.proxy_to_port).to eq(80)
      end
    end

    context 'when set' do
      before do
        subject.proxy_port = proxy_port
      end

      it 'returns configured port' do
        expect(subject.proxy_to_port).to eq(proxy_port)
      end
    end
  end

  describe 'proxy_uri' do
    context 'proxy set to true' do
      before { subject.proxy = true }

      describe 'no proxy host' do
        it 'returns nil' do
          expect(subject.proxy_uri).to be_nil
        end
      end

      describe 'with proxy host' do
        let(:uri) { subject.proxy_uri.to_s }

        before do
          subject.proxy_host = proxy_host
        end

        it 'returns uri with proxy info' do
          expect(uri).to match(proxy_host)
          expect(uri).to match(/#{subject.proxy_to_port}/)
        end

        context 'and user info' do
          before do
            subject.proxy_user = proxy_user
            subject.proxy_pass = proxy_pass
          end

          it 'returns uri with proxy info' do
            expect(uri).to match("#{subject.proxy_user}:#{subject.proxy_pass}")
          end
        end
      end
    end

    context 'proxy set to false' do
      it 'returns nil' do
        expect(subject.proxy_uri).to be_nil
      end
    end
  end
end
