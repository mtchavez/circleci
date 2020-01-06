# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CircleCi::Projects, :vcr do
  subject(:projects) { described_class.new }

  describe 'initialize' do
    context 'with default config' do
      it 'is set to global config' do
        expect(projects.conf).to eq(CircleCi.config)
      end
    end
  end

  describe 'get' do
    context 'when successful' do
      let(:res) { projects.get }

      it_behaves_like 'a successful response'

      describe 'projects' do
        let(:response) { res.body }
        let(:metadata_keys) { %w[default_branch vcs_url] }
        let(:project) { response.first }

        it 'has correct size' do
          expect(response.size).to be 7
        end

        it 'has metadata' do
          aggregate_failures do
            metadata_keys.each do |key|
              expect(project).to have_key(key), "Expected #{key} to exist in build"
            end
          end
        end
      end
    end
  end
end
