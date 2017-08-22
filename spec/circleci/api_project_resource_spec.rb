# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CircleCi::ApiProjectResource do
  let(:username) { 'mtchavez' }
  let(:project)  { 'circleci' }
  let(:vcs)      { described_class::DEFAULT_VCS_TYPE }
  let(:build)    { nil }
  subject        { described_class.new username, project, vcs, build }

  describe 'initialize' do
    context 'vcs type' do
      describe 'default' do
        it 'sets to github' do
          expect(subject.vcs_type).to eq(described_class::DEFAULT_VCS_TYPE)
        end
      end

      describe 'valid alternate' do
        let(:vcs) { 'bitbucket' }

        it 'sets vcs type' do
          expect(subject.vcs_type).to eq(vcs)
        end
      end

      describe 'invalid' do
        let(:vcs) { 'gitlab' }

        it 'uses default' do
          expect(subject.vcs_type).to eq(described_class::DEFAULT_VCS_TYPE)
        end
      end
    end

    context 'build' do
      let(:build) { '12345' }

      it 'can be set' do
        expect(subject.build).to eq(build)
      end
    end

    context 'custom config' do
      let(:custom_port) { 9090 }
      let(:new_config) { CircleCi::Config.new(port: custom_port) }
      subject { described_class.new username, project, vcs, build, new_config }

      it 'can be set' do
        expect(subject.conf).not_to eq(CircleCi.config)
        expect(subject.conf).to eq(new_config)
        expect(subject.conf.port).to eq(custom_port)
      end
    end
  end

  describe 'default_config' do
    it 'returns global config' do
      expect(subject.conf).to eq(CircleCi.config)
    end
  end
end
