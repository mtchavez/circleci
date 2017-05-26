# frozen_string_literal: true
require 'spec_helper'

RSpec.describe CircleCi::RecentBuilds, :vcr do
  describe 'get' do
    context 'successfully' do
      let(:res) { subject.get }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'recent builds' do
        let(:builds) { res.body }

        it 'has metadata' do
          expect(builds).to be_instance_of(Array)
          expect(builds.size).to eq 30
        end

        context 'first build' do
          let(:build) { builds.first }

          it 'has metadata' do
            expect(build).to be_instance_of(Hash)
            expect(build).to have_key 'build_num'
            expect(build).to have_key 'build_url'
            expect(build).to have_key 'status'
          end
        end
      end

      describe 'with limit' do
        let(:res) { subject.get limit: 3 }
        let(:body) { res.body }

        it 'returns correct total of builds' do
          expect(body.size).to eq 3
        end
      end
    end
  end
end
