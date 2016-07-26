# frozen_string_literal: true
require 'spec_helper'

RSpec.describe CircleCi::Build, :vcr do
  describe 'artifacts' do
    context 'successfully' do
      let(:res) { described_class.artifacts 'mtchavez', 'circleci', 140 }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'artifacts' do
        subject(:artifacts) { res.body }

        it 'are returned' do
          expect(subject.size).to eql 1
          expect(subject).to be_instance_of(Array)
        end

        context 'first artifact' do
          subject { artifacts.first }

          it 'has metadata' do
            expect(subject).to be_instance_of(Hash)
            expect(subject).to have_key 'url'
            expect(subject).to have_key 'node_index'
            expect(subject).to have_key 'pretty_path'
            expect(subject).to have_key 'path'
          end
        end
      end
    end
  end

  describe 'cancel' do
    context 'successfully' do
      let(:res) { described_class.cancel 'mtchavez', 'circleci', 145 }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'canceled build' do
        subject { res.body }

        it 'has metadata' do
          expect(subject).to be_instance_of(Hash)
          expect(subject['status']).to eql 'canceled'
          expect(subject['outcome']).to eql 'canceled'
          expect(subject['canceled']).to be_truthy
        end
      end
    end
  end

  describe 'get' do
    context 'successfully' do
      let(:res) { described_class.get 'mtchavez', 'circleci', 140 }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'build' do
        subject { res.body }

        it 'has metadata' do
          expect(subject).to be_instance_of(Hash)

          expect(subject).to have_key 'committer_name'
          expect(subject).to have_key 'messages'
          expect(subject).to have_key 'start_time'
          expect(subject).to have_key 'stop_time'
          expect(subject).to have_key 'status'
          expect(subject).to have_key 'subject'
        end
      end
    end
  end

  describe 'retry' do
    context 'successfully' do
      let(:res) { described_class.retry 'mtchavez', 'circleci', 140 }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'build' do
        subject { res.body }

        it 'has metadata' do
          expect(subject).to be_instance_of(Hash)
          expect(subject['status']).to eql 'scheduled'
          expect(subject).to have_key 'committer_name'
          expect(subject).to have_key 'messages'
          expect(subject).to have_key 'start_time'
          expect(subject).to have_key 'stop_time'
          expect(subject).to have_key 'status'
          expect(subject).to have_key 'subject'
        end
      end
    end
  end

  describe 'tests' do
    context 'successfully' do
      let(:res) { described_class.tests 'mtchavez', 'circleci', 140 }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'for build' do
        subject { res.body['tests'] }

        it { expect(subject.size).to equal 78 }

        describe 'a test' do
          subject { res.body['tests'].first }

          it { expect(subject).to be_instance_of(Hash) }
          it { expect(subject).to have_key 'file' }
          it { expect(subject).to have_key 'source' }
          it { expect(subject).to have_key 'result' }
        end
      end
    end
  end
end
