# frozen_string_literal: true
require 'spec_helper'

RSpec.describe CircleCi::RecentBuilds, :vcr do
  xdescribe 'get' do
    context 'successfully' do
      let(:res) { described_class.get }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'recent builds' do
        subject(:builds) { res.body }

        it 'has metadata' do
          expect(subject).to be_instance_of(Array)
          expect(subject.size).to eq 30
        end

        context 'first build' do
          subject { builds.first }

          it 'has metadata' do
            expect(subject).to be_instance_of(Hash)
            expect(subject).to have_key 'build_num'
            expect(subject).to have_key 'build_url'
            expect(subject).to have_key 'status'
          end
        end
      end

      describe 'with limit' do
        let(:res) { described_class.get limit: 3 }
        subject { res.body }

        it 'returns correct total of builds' do
          expect(subject.size).to eq 3
        end
      end
    end
  end
end
