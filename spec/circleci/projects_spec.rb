# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CircleCi::Projects, :vcr do
  describe 'initialize' do
    context 'default config' do
      it 'is set to global config' do
        expect(subject.conf).to eq(CircleCi.config)
      end
    end
  end

  describe 'get' do
    context 'successfully' do
      let(:res) { subject.get }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'projects' do
        let(:projects) { res.body }

        it 'has metadata' do
          expect(projects).to be_instance_of(Array)
          expect(projects.size).to eql 7

          project = projects.first
          expect(project).to have_key('default_branch')
          expect(project).to have_key('vcs_url')
        end
      end
    end
  end
end
