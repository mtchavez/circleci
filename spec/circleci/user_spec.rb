# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CircleCi::User, :vcr do
  subject(:user) { described_class.new }

  describe 'me' do
    context 'when successful' do
      let(:res) { user.me }

      it_behaves_like 'a successful response'

      describe 'user' do
        let(:response) { res.body }
        let(:metadata_keys) { %w[login admin] }

        it 'has metadata' do
          aggregate_failures do
            metadata_keys.each do |key|
              expect(response).to have_key(key), "Expected #{key} to exist in user"
            end
          end
        end
      end
    end

    context 'with custom config' do
      let(:custom_port) { 9090 }
      let(:custom_config) { CircleCi::Config.new(port: custom_port) }
      let(:new_user) { described_class.new custom_config }
      let(:fake_request) { instance_double('CircleCi::Request') }

      before do
        allow(fake_request).to receive(:get)
        allow(CircleCi).to receive(:request).with(custom_config, '/me').and_return(fake_request)
        new_user.me
      end

      it 'makes request with custom config' do
        expect(CircleCi).to have_received(:request).with(custom_config, '/me')
      end
    end
  end

  describe 'heroku-key' do
    context 'when successful' do
      let(:res) { user.heroku_key test_heroku_key }

      it_behaves_like 'a successful response'
    end
  end
end
