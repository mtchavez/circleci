# frozen_string_literal: true
require 'spec_helper'

RSpec.describe CircleCi::User, :vcr do
  describe 'me' do
    context 'successfully' do
      let(:res) { subject.me }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'user' do
        let(:body) { res.body }

        it 'has metadata' do
          expect(body['login']).to eql 'mtchavez'
          expect(body['admin']).to be_falsy
        end
      end
    end

    context 'custom config' do
      let(:custom_port) { 9090 }
      let(:custom_config) { CircleCi::Config.new(port: custom_port) }
      let(:new_user) { described_class.new custom_config }
      let(:fake_request) { instance_double('CircleCi::Request') }

      it 'makes request with custom config' do
        expect(CircleCi).to receive(:request).with(custom_config, '/me').and_return(fake_request)
        expect(fake_request).to receive(:get)
        expect(new_user.conf).not_to eq(CircleCi.config)
        expect(new_user.conf).to eq(custom_config)
        expect(new_user.conf.port).to eq(custom_port)
        new_user.me
      end
    end
  end

  describe 'heroku-key' do
    context 'successfully' do
      let(:res) { subject.heroku_key test_heroku_key }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end
    end
  end
end
