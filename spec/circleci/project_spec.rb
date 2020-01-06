# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CircleCi::Project, :vcr do
  let(:username) { 'mtchavez' }
  let(:project)  { 'circleci' }
  let(:branch)   { 'master' }
  let(:new_project) { described_class.new username, project }

  describe 'build' do
    context 'when successful' do
      let(:res) { new_project.build }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has a successful response' do
        expect(res).to be_success
      end

      describe 'build' do
        subject(:response) { res.body }

        let(:metadata_keys) { %w[branch committer_name messages start_time stop_time status subject] }

        it 'has metadata' do
          aggregate_failures do
            metadata_keys.each do |key|
              expect(response).to have_key(key), "Expected #{key} to exist in build"
            end
          end
        end
      end
    end
  end

  describe 'build_branch' do
    context 'when successful' do
      let(:res) { new_project.build_branch branch }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has a successful response' do
        expect(res).to be_success
      end

      describe 'build' do
        subject(:response) { res.body }

        let(:metadata_keys) { %w[messages start_time stop_time status subject] }

        it 'returns newly created build' do
          expect(response['branch']).to eql 'master'
        end

        it 'has metadata' do
          aggregate_failures do
            metadata_keys.each do |key|
              expect(response).to have_key(key), "Expected #{key} to exist in build"
            end
          end
        end
      end
    end

    context 'when experimental api' do
      let(:res) { new_project.build_branch branch, {}, 'SOME_VAR' => '123' }

      it_behaves_like 'a successful response'
    end
  end

  describe 'build_ssh_key' do
    let(:build_num) { 65 }
    let(:ssh_key)   { 'RSA Private Key' }
    let(:ssh_host)  { 'hostname' }

    context 'when successful' do
      let(:res) { new_project.build_ssh_key build_num, ssh_key, ssh_host }

      it_behaves_like 'a successful response'
    end
  end

  describe 'clear_cache' do
    context 'when successful' do
      let(:res) { new_project.clear_cache }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has a successful response' do
        expect(res).to be_success
      end

      describe 'message' do
        subject(:response) { res.body }

        it 'has metadata' do
          expect(response['status']).to eql 'build dependency caches deleted'
        end
      end
    end
  end

  describe 'delete_checkout_key' do
    context 'when successful' do
      let(:res) { new_project.delete_checkout_key test_delete_checkout_key_fingerprint }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has a successful response' do
        expect(res).to be_success
      end

      it 'has ok message' do
        expect(res.body['message']).to eql 'ok'
      end
    end

    context 'when unsuccessful' do
      let(:res) { new_project.delete_checkout_key 'asdf-bogus' }
      let(:message) { 'checkout key not found' }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has an unsuccessful response' do
        expect(res).not_to be_success
      end

      describe 'message' do
        subject(:response) { res.body }

        it 'has metadata' do
          expect(response['message']).to eql message
        end
      end
    end
  end

  describe 'enable' do
    context 'when successful' do
      let(:project) { 'dotfiles' }
      let(:res) { new_project.enable }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has a successful response' do
        expect(res).to be_success
      end

      describe 'project checkout keys' do
        let(:res) { new_project.list_checkout_keys }
        let(:project_res) { res.body }

        it 'has a public key' do
          expect(project_res.first).to have_key('public_key')
        end

        it 'has a deploy key' do
          expect(project_res.first['type']).to eql('deploy-key')
        end
      end
    end
  end

  describe 'envvar' do
    context 'when successful' do
      let(:res) { new_project.envvar }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has a successful response' do
        expect(res).to be_success
      end

      describe 'envvars' do
        let(:envvars) { res.body }

        it 'has list' do
          expect(envvars.size).to be 2
        end

        context 'when first envvar' do
          let(:envvar) { envvars.first }

          it 'returns a response hash' do
            expect(envvar).to eq('name' => 'COVERALLS_REPO_TOKEN', 'value' => 'xxxxskJS')
          end
        end
      end
    end

    context 'when unsuccessful' do
      let(:project) { 'asdf-bogus' }
      let(:res) { new_project.envvar }
      let(:message) { 'Project not found' }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has an unsuccessful response' do
        expect(res).not_to be_success
      end

      describe 'message' do
        subject(:response) { res.body }

        it 'returns an error message' do
          # NOTE: Appears to be a bug with this response returning a message
          #       that is a JSON string of a github API response
          expect(response['message']).to match(/Not Found/)
        end
      end
    end
  end

  describe 'follow' do
    context 'when successful' do
      let(:res) { new_project.follow }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has a successful response' do
        expect(res).to be_success
      end

      describe 'message' do
        subject(:response) { res.body }

        it 'has metadata' do
          expect(response['followed']).to be_truthy
        end
      end
    end
  end

  describe 'get_checkout_key' do
    context 'when successful' do
      let(:res) { new_project.get_checkout_key test_checkout_key_fingerprint }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has a successful response' do
        expect(res).to be_success
      end

      describe 'key' do
        let(:key) { res.body }

        it 'matches public key format' do
          expect(key['public_key']).to match(/^ssh-rsa/)
        end

        it 'has correct deploy-key type' do
          expect(key['type']).to eql 'deploy-key'
        end

        it 'matches fingerprint of the key' do
          expect(key['fingerprint']).to eql test_checkout_key_fingerprint
        end
      end
    end

    context 'when unsuccessful' do
      let(:res) { new_project.get_checkout_key 'asdf-bogus' }
      let(:message) { 'checkout key not found' }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has an unsuccessful response' do
        expect(res).not_to be_success
      end

      describe 'message' do
        subject(:response) { res.body }

        it 'has metadata' do
          expect(response['message']).to eql message
        end
      end
    end
  end

  describe 'list_checkout_keys' do
    context 'when successful' do
      let(:res) { new_project.list_checkout_keys }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has a successful response' do
        expect(res).to be_success
      end

      describe 'keys' do
        let(:keys) { res.body }

        it 'are returned' do
          expect(keys.size).to be 1
        end

        context 'with first key' do
          let(:key) { keys.first }
          let(:metadata_keys) { %w[public_key type fingerprint] }

          it 'has metadata' do
            aggregate_failures do
              metadata_keys.each do |keyname|
                expect(key).to have_key(keyname), "Expected #{keyname} to exist in key"
              end
            end
          end
        end
      end
    end
  end

  describe 'new_checkout_key' do
    context 'when successful' do
      let(:res) { new_project.new_checkout_key 'deploy-key' }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has a successful response' do
        expect(res).to be_success
      end

      describe 'key' do
        let(:key) { res.body }

        it 'matches public key format' do
          expect(key['public_key']).to match(/^ssh-rsa/)
        end

        it 'has correct deploy-key type' do
          expect(key['type']).to eql 'deploy-key'
        end

        it 'returns fingerprint of the key' do
          expect(key).to have_key 'fingerprint'
        end
      end
    end

    context 'when unsuccessful' do
      let(:username) { 'github' }
      let(:project) { 'hub' }
      let(:res) { new_project.new_checkout_key 'deploy-key' }
      let(:message) { 'Permission denied' }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has an unsuccessful response' do
        expect(res).not_to be_success
      end

      describe 'message' do
        subject(:response) { res.body }

        it 'has metadata' do
          expect(response['message']).to eql message
        end
      end
    end
  end

  describe 'recent_builds' do
    context 'when successful' do
      let(:res) { new_project.recent_builds }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has a successful response' do
        expect(res).to be_success
      end

      describe 'projects' do
        let(:projects) { res.body }

        it 'are returned in a list' do
          expect(projects.size).to be 30
        end

        describe 'first project' do
          let(:first_project) { projects.first }
          let(:metadata_keys) { %w[committer_name messages start_time stop_time status subject] }

          it 'has metadata' do
            aggregate_failures do
              metadata_keys.each do |key|
                expect(first_project).to have_key(key), "Expected #{key} to exist in build"
              end
            end
          end
        end
      end

      describe 'params' do
        context 'with limit' do
          let(:res) { new_project.recent_builds limit: 5 }

          it_behaves_like 'a successful response'

          it 'returns correct total of builds' do
            expect(res.body.size).to be 5
          end
        end

        context 'with filter' do
          let(:res) { new_project.recent_builds limit: 5, filter: 'failed' }

          it_behaves_like 'a successful response'

          it 'returns builds filtered by status' do
            builds = res.body
            statuses = builds.map { |build| build['status'] }
            failed_statuses = %w[failed no_tests]
            statuses.each { |status| expect(failed_statuses).to include(status) }
          end
        end
      end
    end
  end

  describe 'recent_builds_branch' do
    context 'when successful' do
      let(:res) { new_project.recent_builds_branch branch }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has a successful response' do
        expect(res).to be_success
      end

      describe 'projects' do
        let(:projects) { res.body }

        it 'are returned in a list' do
          expect(projects.size).to be 30
        end

        describe 'first project' do
          let(:first_project) { projects.first }
          let(:metadata_keys) { %w[committer_name messages start_time stop_time status subject] }

          it 'has metadata' do
            aggregate_failures do
              metadata_keys.each do |key|
                expect(first_project).to have_key(key), "Expected #{key} to exist in build"
              end
            end
          end
        end
      end
    end
  end

  describe 'settings' do
    context 'when successful' do
      let(:res) { new_project.settings }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has a successful response' do
        expect(res).to be_success
      end

      describe 'project' do
        let(:project_res) { res.body }
        let(:metadata_keys) { %w[vcs-type branches default_branch] }

        it 'has metadata' do
          aggregate_failures do
            metadata_keys.each do |key|
              expect(project_res).to have_key(key), "Expected #{key} to exist in project"
            end
          end
        end
      end
    end
  end

  describe 'add_envvar' do
    context 'when successful' do
      let(:res) { new_project.add_envvar name: 'TESTENV', value: 'testvalue' }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has a successful response' do
        expect(res).to be_success
      end

      describe 'envvar' do
        subject(:envvar) { res.body }

        it 'has metadata' do
          expect(envvar).to eq('name' => 'TESTENV', 'value' => 'xxxxalue')
        end
      end
    end

    context 'when unsuccessful' do
      let(:project) { 'asdf-bogus' }
      let(:res) { new_project.add_envvar name: 'TESTENV', value: 'testvalue' }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has an unsuccessful response' do
        expect(res).not_to be_success
      end

      describe 'message' do
        subject(:response) { res.body }

        it 'returns an error message' do
          # NOTE: Appears to be a bug with this response returning a message
          #       that is a JSON string of a github API response
          expect(response['message']).to match(/Not Found/i)
        end
      end
    end
  end

  describe 'delete_envvar' do
    context 'when successful' do
      let(:temp_var) { new_project.add_envvar name: 'DELETE_ME', value: 'testvalue' }
      let(:res) { new_project.delete_envvar 'DELETE_ME' }

      before { temp_var }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has an unsuccessful response' do
        expect(res).to be_success
      end

      describe 'envvar' do
        let(:envvar) { res.body }

        it 'has metadata' do
          expect(envvar['message']).to eq 'ok'
        end
      end
    end

    context 'when unsuccessful' do
      let(:project) { 'delete_envvar-bogus' }
      let(:res) { new_project.delete_envvar 'DELETE_ME' }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has an unsuccessful response' do
        expect(res).not_to be_success
      end

      describe 'message' do
        subject(:response) { res.body }

        it 'returns an error message' do
          # NOTE: Appears to be a bug with this response returning a message
          #       that is a JSON string of a github API response
          expect(response['message']).to match(/Not Found/i)
        end
      end
    end
  end

  describe 'ssh_key' do
    context 'when successful' do
      let(:res) { new_project.ssh_key test_rsa_private_key, 'hostname' }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has a successful response' do
        expect(res).to be_success
      end
    end

    context 'when unsuccessful' do
      let(:res) { new_project.ssh_key 'RSA Private Key', 'hostname' }
      let(:message) { 'it looks like private key is invalid key.  Double check' }

      it_behaves_like 'an unsuccessful response'

      describe 'message' do
        subject(:response) { res.body }

        it 'has metadata' do
          expect(response['message']).to eql message
        end
      end
    end
  end

  describe 'unfollow' do
    context 'when successful' do
      let(:res) { new_project.unfollow }

      it 'is a response object' do
        expect(res).to be_instance_of(CircleCi::Response)
      end

      it 'has a successful response' do
        expect(res).to be_success
      end

      describe 'message' do
        subject(:response) { res.body }

        it 'has metadata' do
          expect(response['followed']).to be_falsy
        end
      end
    end
  end
end
