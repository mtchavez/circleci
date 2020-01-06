# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CircleCi::RecentBuilds, :vcr do
  subject(:builds) { described_class.new }

  describe 'get' do
    context 'when successful' do
      let(:res) { builds.get }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has a successful response' do
        expect(res).to be_success
      end

      describe 'recent builds' do
        let(:response) { res.body }

        it 'has correct number of builds' do
          expect(response.size).to eq(30)
        end

        context 'with first build' do
          let(:build) { response.first }
          let(:metadata_keys) { %w[build_num build_url status] }

          it 'has metadata' do
            aggregate_failures do
              metadata_keys.each do |key|
                expect(build).to have_key(key), "Expected #{key} to exist in build"
              end
            end
          end
        end
      end

      describe 'with limit' do
        let(:res) { builds.get limit: 3 }
        let(:response) { res.body }

        it 'returns correct total of builds' do
          expect(response.size).to eq(3)
        end
      end
    end
  end
end
