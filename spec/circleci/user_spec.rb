# frozen_string_literal: true
require 'spec_helper'

RSpec.describe CircleCi::User, :vcr do
  xdescribe 'me' do
    context 'successfully' do
      let(:res) { described_class.me }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'user' do
        subject { res.body }

        it 'has metadata' do
          expect(subject['login']).to eql 'mtchavez'
          expect(subject['admin']).to be_falsy
        end
      end
    end
  end

  xdescribe 'heroku-key' do
    context 'successfully' do
      let(:res) { described_class.heroku_key test_heroku_key }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end
    end
  end
end
