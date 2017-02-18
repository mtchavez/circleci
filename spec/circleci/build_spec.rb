# frozen_string_literal: true
require 'spec_helper'

RSpec.describe CircleCi::Build, :vcr do
  let(:username)  { 'mtchavez' }
  let(:project)   { 'circleci' }
  let(:build_num) { 140 }
  let(:new_build) { described_class.new username, project, build_num }

  describe 'artifacts' do
    context 'successfully' do
      let(:res) { new_build.artifacts }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'deprecated class method' do
        let(:res) { described_class.artifacts username, project, build_num }

        it 'logs deprecation and calls instance method' do
          expect(CircleCi.config.logger).to receive(:warn).with('[Deprecated] Use instance method CircleCi::Build#artifacts instead')
          expect(described_class).to receive(:new).with(username, project, build_num, CircleCi.config).and_return(new_build)
          expect(new_build).to receive(:artifacts).and_call_original
          expect(res).to be_instance_of(CircleCi::Response)
        end
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

      describe 'deprecated class method' do
        let(:res) { described_class.cancel username, project, build_num }

        it 'logs deprecation and calls instance method' do
          expect(CircleCi.config.logger).to receive(:warn).with('[Deprecated] Use instance method CircleCi::Build#cancel instead')
          expect(described_class).to receive(:new).with(username, project, build_num, CircleCi.config).and_return(new_build)
          expect(new_build).to receive(:cancel).and_call_original
          expect(res).to be_instance_of(CircleCi::Response)
        end
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

      describe 'deprecated class method' do
        let(:res) { described_class.get username, project, build_num }

        it 'logs deprecation and calls instance method' do
          expect(CircleCi.config.logger).to receive(:warn).with('[Deprecated] Use instance method CircleCi::Build#get instead')
          expect(described_class).to receive(:new).with(username, project, build_num, CircleCi.config).and_return(new_build)
          expect(new_build).to receive(:get).and_call_original
          expect(res).to be_instance_of(CircleCi::Response)
        end
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

      describe 'deprecated class method' do
        let(:res) { described_class.retry username, project, build_num }

        it 'logs deprecation and calls instance method' do
          expect(CircleCi.config.logger).to receive(:warn).with('[Deprecated] Use instance method CircleCi::Build#retry instead')
          expect(described_class).to receive(:new).with(username, project, build_num, CircleCi.config).and_return(new_build)
          expect(new_build).to receive(:retry).and_call_original
          expect(res).to be_instance_of(CircleCi::Response)
        end
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

      describe 'deprecated class method' do
        let(:res) { described_class.tests username, project, build_num }

        it 'logs deprecation and calls instance method' do
          expect(CircleCi.config.logger).to receive(:warn).with('[Deprecated] Use instance method CircleCi::Build#tests instead')
          expect(described_class).to receive(:new).with(username, project, build_num, CircleCi.config).and_return(new_build)
          expect(new_build).to receive(:tests).and_call_original
          expect(res).to be_instance_of(CircleCi::Response)
        end
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
