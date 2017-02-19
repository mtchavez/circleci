# frozen_string_literal: true
require 'spec_helper'

RSpec.describe CircleCi::ApiResource do
  let(:username) { 'mtchavez' }
  let(:project)  { 'circleci' }

  describe 'initialize' do
    context 'default config' do
      it 'is set to global config' do
        expect(subject.conf).to eq(CircleCi.config)
      end
    end

    context 'custom config' do
      let(:custom_port) { 9090 }
      let(:new_config) { CircleCi::Config.new(port: custom_port) }
      subject { described_class.new username, project, new_config }

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
