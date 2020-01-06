# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CircleCi::ApiProjectResource do
  subject(:resource) { described_class.new username, project, vcs, build }

  let(:username) { 'mtchavez' }
  let(:project)  { 'circleci' }
  let(:vcs)      { described_class::DEFAULT_VCS_TYPE }
  let(:build)    { nil }

  describe 'initialize' do
    context 'with vcs type' do
      describe 'default' do
        it 'sets to github' do
          expect(resource.vcs_type).to eq(described_class::DEFAULT_VCS_TYPE)
        end
      end

      describe 'valid alternate' do
        let(:vcs) { 'bitbucket' }

        it 'sets vcs type' do
          expect(resource.vcs_type).to eq(vcs)
        end
      end

      describe 'invalid' do
        let(:vcs) { 'gitlab' }

        it 'uses default' do
          expect(resource.vcs_type).to eq(described_class::DEFAULT_VCS_TYPE)
        end
      end
    end

    context 'with build' do
      let(:build) { '12345' }

      it 'can be set' do
        expect(resource.build).to eq(build)
      end
    end

    context 'with custom config' do
      subject(:resource) { described_class.new username, project, vcs, build, new_config }

      let(:custom_port) { 9090 }
      let(:new_config) { CircleCi::Config.new(port: custom_port) }

      it 'does not set global config' do
        expect(resource.conf).not_to eq(CircleCi.config)
      end

      it 'sets the config on the resource' do
        expect(resource.conf).to eq(new_config)
      end

      it 'uses new config' do
        expect(resource.conf.port).to eq(custom_port)
      end
    end
  end

  describe 'default_config' do
    it 'returns global config' do
      expect(resource.conf).to eq(CircleCi.config)
    end
  end
end
