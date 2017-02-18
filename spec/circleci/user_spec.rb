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

      describe 'deprecated class method' do
        let(:res) { described_class.me }

        it 'logs deprecation and calls instance method' do
          expect(CircleCi.config.logger).to receive(:warn).with('[Deprecated] Use instance method CircleCi::User#me instead')
          expect(described_class).to receive(:new).with(CircleCi.config).and_return(subject)
          expect(subject).to receive(:me).and_call_original
          expect(res).to be_instance_of(CircleCi::Response)
        end
      end

      describe 'user' do
        let(:body) { res.body }

        it 'has metadata' do
          expect(body['login']).to eql 'mtchavez'
          expect(body['admin']).to be_falsy
        end
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

      describe 'deprecated class method' do
        let(:res) { described_class.heroku_key test_heroku_key }

        it 'logs deprecation and calls instance method' do
          expect(CircleCi.config.logger).to receive(:warn).with('[Deprecated] Use instance method CircleCi::User#heroku_key instead')
          expect(described_class).to receive(:new).with(CircleCi.config).and_return(subject)
          expect(subject).to receive(:heroku_key).with(test_heroku_key).and_call_original
          expect(res).to be_instance_of(CircleCi::Response)
        end
      end
    end
  end
end
