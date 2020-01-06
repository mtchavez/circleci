# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CircleCi::Build, :vcr do
  let(:username)  { 'mtchavez' }
  let(:project)   { 'circleci' }
  let(:vcs)       { CircleCi::ApiProjectResource::DEFAULT_VCS_TYPE }
  let(:build_num) { 140 }
  let(:new_build) { described_class.new username, project, vcs, build_num }

  describe 'artifacts' do
    context 'when successful' do
      let(:res) { new_build.artifacts }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has a successful response' do
        expect(res).to be_success
      end

      describe 'artifacts' do
        subject(:artifacts) { res.body }

        it 'are returned' do
          expect(artifacts.size).to be 1
        end

        context 'with first artifact' do
          subject(:artifact) { artifacts.first }

          let(:metadata_keys) { %w[url node_index pretty_path path] }

          it 'has metadata' do
            aggregate_failures do
              metadata_keys.each do |key|
                expect(artifact).to have_key(key), "Expected #{key} to exist in artifact"
              end
            end
          end
        end
      end
    end
  end

  describe 'cancel' do
    context 'when successful' do
      let(:build_num) { 145 }
      let(:res) { new_build.cancel }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has a successful response' do
        expect(res).to be_success
      end

      describe 'canceled build' do
        subject(:response) { res.body }

        it 'has correct status' do
          expect(response['status']).to eql 'canceled'
        end

        it 'is canceled' do
          expect(response['canceled']).to be_truthy
        end
      end
    end
  end

  describe 'get' do
    context 'when successful' do
      let(:res) { new_build.get }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has a successful response' do
        expect(res).to be_success
      end

      describe 'build' do
        subject(:response) { res.body }

        let(:metadata_keys) { %w[committer_name messages start_time stop_time status subject] }

        it 'has metadata' do
          aggregate_failures do
            metadata_keys.each do |key|
              expect(response).to have_key(key), "Expected #{key} to exist in build response"
            end
          end
        end
      end
    end
  end

  describe 'retry' do
    context 'when successful' do
      let(:res) { new_build.retry }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has a successful response' do
        expect(res).to be_success
      end

      describe 'build' do
        subject(:response) { res.body }

        let(:metadata_keys) { %w[committer_name messages start_time stop_time status subject] }

        it 'has correct status' do
          expect(response['status']).to eql 'not_run'
        end

        it 'has metadata' do
          aggregate_failures do
            metadata_keys.each do |key|
              expect(response).to have_key(key), "Expected #{key} to exist in build response"
            end
          end
        end
      end
    end
  end

  describe 'tests' do
    context 'when successful' do
      let(:res) { new_build.tests }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has a successful response' do
        expect(res).to be_success
      end

      describe 'for build' do
        subject(:tests) { res.body['tests'] }

        it { expect(tests.size).to equal 78 }

        context 'with a test' do
          subject(:test) { res.body['tests'].first }

          it { expect(test).to be_instance_of(Hash) }
          it { expect(test).to have_key 'file' }
          it { expect(test).to have_key 'source' }
          it { expect(test).to have_key 'result' }
        end
      end
    end
  end
end
