# frozen_string_literal: true
require 'spec_helper'

RSpec.describe CircleCi::Build, :vcr do
  let(:username)  { 'mtchavez' }
  let(:project)   { 'circleci' }
  let(:vcs)       { CircleCi::ApiProjectResource::DEFAULT_VCS_TYPE }
  let(:build_num) { 140 }
  let(:new_build) { described_class.new username, project, vcs, build_num }

  describe 'artifacts' do
    context 'successfully' do
      let(:res) { new_build.artifacts }

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
      let(:build_num) { 145 }
      let(:res) { new_build.cancel }

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
      let(:res) { new_build.get }

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
      let(:res) { new_build.retry }

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
      let(:res) { new_build.tests }

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
