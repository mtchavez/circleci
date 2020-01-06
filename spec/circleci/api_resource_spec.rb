# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CircleCi::ApiResource do
  subject(:resource) { described_class.new }

  let(:username) { 'mtchavez' }
  let(:project)  { 'circleci' }

  describe 'initialize' do
    context 'with default config' do
      it 'is set to global config' do
        expect(resource.conf).to eq(CircleCi.config)
      end
    end

    context 'with custom config' do
      subject(:resource) { described_class.new username, project, new_config }

      let(:custom_port) { 9090 }
      let(:new_config) { CircleCi::Config.new(port: custom_port) }

      it 'does not equal global config' do
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
