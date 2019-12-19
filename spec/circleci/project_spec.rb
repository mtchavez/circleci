# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CircleCi::Project, :vcr do
  let(:username) { 'mtchavez' }
  let(:project)  { 'circleci' }
  let(:branch)   { 'master' }
  let(:new_project) { described_class.new username, project }

  describe 'build' do
    context 'successfully' do
      let(:res) { new_project.build }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'build' do
        subject { res.body }

        it 'has metadata' do
          expect(subject).to be_instance_of(Hash)
          expect(subject['committer_name']).to eql 'Chavez'
          expect(subject['branch']).to eql 'master'

          expect(subject).to have_key 'messages'
          expect(subject).to have_key 'start_time'
          expect(subject).to have_key 'stop_time'
          expect(subject).to have_key 'status'
          expect(subject).to have_key 'subject'
        end
      end
    end
  end

  describe 'build_branch' do
    context 'successfully' do
      let(:res) { new_project.build_branch branch }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'build' do
        subject { res.body }

        it 'returns newly created build' do
          expect(subject).to be_instance_of(Hash)
          expect(subject['committer_name']).to eql 'Chavez'
          expect(subject['branch']).to eql 'master'

          expect(subject).to have_key 'messages'
          expect(subject).to have_key 'start_time'
          expect(subject).to have_key 'stop_time'
          expect(subject).to have_key 'status'
          expect(subject).to have_key 'subject'
        end
      end
    end

    context 'experimental api' do
      let(:res) { new_project.build_branch branch, {}, 'SOME_VAR' => '123' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end
    end
  end

  describe 'build_ssh_key' do
    let(:build_num) { 65 }
    let(:ssh_key)   { 'RSA Private Key' }
    let(:ssh_host)  { 'hostname' }

    context 'successfully' do
      let(:res) { new_project.build_ssh_key build_num, ssh_key, ssh_host }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end
    end
  end

  describe 'clear_cache' do
    context 'successfully' do
      let(:res) { new_project.clear_cache }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'message' do
        subject { res.body }

        it 'has metadata' do
          expect(subject).to be_instance_of(Hash)
          expect(subject['status']).to eql 'build dependency caches deleted'
        end
      end
    end
  end

  describe 'delete_checkout_key' do
    context 'successfully' do
      let(:res) { new_project.delete_checkout_key test_delete_checkout_key_fingerprint }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
        expect(res.body).to be_instance_of(Hash)
        expect(res.body['message']).to eql 'ok'
      end
    end

    context 'unsuccessfully' do
      let(:res) { new_project.delete_checkout_key 'asdf-bogus' }
      let(:message) { 'checkout key not found' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).not_to be_success
      end

      describe 'message' do
        subject { res.body }

        it 'has metadata' do
          expect(subject).to be_instance_of(Hash)
          expect(subject['message']).to eql message
        end
      end
    end
  end

  describe 'enable' do
    context 'successfully' do
      let(:project) { 'dotfiles' }
      let(:res) { new_project.enable }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'project' do
        let(:res) { new_project.list_checkout_keys }
        let(:project_res) { res.body }

        it 'returns the circleci project settings' do
          expect(project_res).to be_instance_of(Array)
          expect(project_res.first).to have_key('public_key')
          expect(project_res.first['type']).to eql('deploy-key')
        end
      end
    end
  end

  describe 'envvar' do
    context 'successfully' do
      let(:res) { new_project.envvar }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'envvars' do
        let(:envvars) { res.body }

        it 'has list' do
          expect(envvars).to be_instance_of(Array)
          expect(envvars.size).to eql 2
        end

        context 'first envvar' do
          let(:envvar) { envvars.first }

          it 'returns a response hash' do
            expect(envvar).to have_key 'name'
            expect(envvar).to have_key 'value'
          end
        end
      end
    end

    context 'unsuccessfully' do
      let(:project) { 'asdf-bogus' }
      let(:res) { new_project.envvar }
      let(:message) { 'Project not found' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).not_to be_success
      end

      describe 'message' do
        subject { res.body }

        it 'returns an error message' do
          # NOTE: Appears to be a bug with this response returning a message
          #       that is a JSON string of a github API response
          expect(subject).to be_instance_of(Hash)
          expect(subject['message']).to match(/Not Found/)
        end
      end
    end
  end

  describe 'follow' do
    context 'successfully' do
      let(:res) { new_project.follow }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'message' do
        subject { res.body }

        it 'has metadata' do
          expect(subject).to be_instance_of(Hash)
          expect(subject['followed']).to be_truthy
        end
      end
    end
  end

  describe 'get_checkout_key' do
    context 'successfully' do
      let(:res) { new_project.get_checkout_key test_checkout_key_fingerprint }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'key' do
        let(:key) { res.body }

        it 'has metadata' do
          expect(key).to be_instance_of(Hash)
          expect(key['public_key']).to match(/^ssh-rsa/)
          expect(key['type']).to eql 'deploy-key'
          expect(key['fingerprint']).to eql test_checkout_key_fingerprint
        end
      end
    end

    context 'unsuccessfully' do
      let(:res) { new_project.get_checkout_key 'asdf-bogus' }
      let(:message) { 'checkout key not found' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).not_to be_success
      end

      describe 'message' do
        subject { res.body }

        it 'has metadata' do
          expect(subject).to be_instance_of(Hash)
          expect(subject['message']).to eql message
        end
      end
    end
  end

  describe 'list_checkout_keys' do
    context 'successfully' do
      let(:res) { new_project.list_checkout_keys }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'keys' do
        let(:keys) { res.body }

        it 'are returned' do
          expect(keys).to be_instance_of(Array)
          expect(keys.size).to eql 1
        end

        context 'first key' do
          let(:key) { keys.first }

          it 'has metadata' do
            expect(key).to be_instance_of(Hash)
            expect(key).to have_key 'public_key'
            expect(key).to have_key 'type'
            expect(key).to have_key 'fingerprint'
          end
        end
      end
    end
  end

  describe 'new_checkout_key' do
    context 'successfully' do
      let(:res) { new_project.new_checkout_key 'deploy-key' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'key' do
        let(:key) { res.body }

        it 'has metadata' do
          expect(key).to be_instance_of(Hash)
          expect(key['public_key']).to match(/^ssh-rsa/)
          expect(key['type']).to eql 'deploy-key'
          expect(key).to have_key 'fingerprint'
        end
      end
    end

    context 'unsuccessfully' do
      let(:username) { 'github' }
      let(:project) { 'hub' }
      let(:res) { new_project.new_checkout_key 'deploy-key' }
      let(:message) { 'Permission denied' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).not_to be_success
      end

      describe 'message' do
        subject { res.body }

        it 'has metadata' do
          expect(subject).to be_instance_of(Hash)
          expect(subject['message']).to eql message
        end
      end
    end
  end

  describe 'recent_builds' do
    context 'successfully' do
      let(:res) { new_project.recent_builds }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'projects' do
        let(:projects) { res.body }

        it 'are returned in a list' do
          expect(projects).to be_instance_of(Array)
          expect(projects.size).to eql 30
        end

        describe 'first project' do
          let(:first_project) { projects.first }

          it 'has metadata' do
            expect(first_project['committer_name']).to eql 'Chavez'
            expect(first_project).to have_key 'messages'
            expect(first_project).to have_key 'start_time'
            expect(first_project).to have_key 'stop_time'
            expect(first_project).to have_key 'status'
            expect(first_project).to have_key 'subject'
          end
        end
      end

      describe 'params' do
        context 'limit' do
          let(:res) { new_project.recent_builds limit: 5 }

          it 'is verified by response' do
            expect(res).to be_instance_of(CircleCi::Response)
            expect(res).to be_success
          end

          it 'returns correct total of builds' do
            expect(res.body.size).to eql 5
          end
        end

        context 'filter' do
          let(:res) { new_project.recent_builds limit: 5, filter: 'failed' }

          it 'is verified by response' do
            expect(res).to be_instance_of(CircleCi::Response)
            expect(res).to be_success
          end

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
    context 'successfully' do
      let(:res) { new_project.recent_builds_branch branch }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'projects' do
        let(:projects) { res.body }

        it 'are returned in a list' do
          expect(projects).to be_instance_of(Array)
          expect(projects.size).to eql 30
        end

        describe 'first project' do
          let(:first_project) { projects.first }

          it 'has metadata' do
            expect(first_project['committer_name']).to eql 'Chavez'
            expect(first_project).to have_key 'messages'
            expect(first_project).to have_key 'start_time'
            expect(first_project).to have_key 'stop_time'
            expect(first_project).to have_key 'status'
            expect(first_project).to have_key 'subject'
          end
        end
      end
    end
  end

  describe 'settings' do
    context 'successfully' do
      let(:res) { new_project.settings }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'project' do
        let(:project_res) { res.body }

        it 'has metadata' do
          expect(project_res).to be_instance_of(Hash)
          expect(project_res).to have_key 'vcs-type'
          expect(project_res).to have_key 'branches'
          expect(project_res).to have_key 'default_branch'
        end
      end
    end
  end

  describe 'add_envvar' do
    context 'successfully' do
      let(:res) { new_project.add_envvar name: 'TESTENV', value: 'testvalue' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'envvar' do
        let(:envvar) { res.body }

        it 'has metadata' do
          expect(envvar['name']).to eq 'TESTENV'
          # obfuscated value
          expect(envvar['value']).to eq 'xxxxalue'
        end
      end
    end

    context 'unsuccessfully' do
      let(:project) { 'asdf-bogus' }
      let(:res) { new_project.add_envvar name: 'TESTENV', value: 'testvalue' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).not_to be_success
      end

      describe 'message' do
        subject { res.body }

        it 'returns an error message' do
          # NOTE: Appears to be a bug with this response returning a message
          #       that is a JSON string of a github API response
          expect(subject).to be_instance_of(Hash)
          expect(subject['message']).to match(/Not Found/i)
        end
      end
    end
  end

  describe 'delete_envvar' do
    context 'successfully' do
      let(:temp_var) { new_project.add_envvar name: 'DELETE_ME', value: 'testvalue' }
      let(:res) { new_project.delete_envvar 'DELETE_ME' }

      before { temp_var }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'envvar' do
        let(:envvar) { res.body }

        it 'has metadata' do
          expect(envvar['message']).to eq 'ok'
        end
      end
    end

    context 'unsuccessfully' do
      let(:project) { 'delete_envvar-bogus' }
      let(:res) { new_project.delete_envvar 'DELETE_ME' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).not_to be_success
      end

      describe 'message' do
        subject { res.body }

        it 'returns an error message' do
          # NOTE: Appears to be a bug with this response returning a message
          #       that is a JSON string of a github API response
          expect(subject).to be_instance_of(Hash)
          expect(subject['message']).to match(/Not Found/i)
        end
      end
    end
  end

  describe 'ssh_key' do
    context 'successfully' do
      let(:res) { new_project.ssh_key test_rsa_private_key, 'hostname' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end
    end

    context 'unsuccessfully' do
      let(:res) { new_project.ssh_key 'RSA Private Key', 'hostname' }
      let(:message) { 'it looks like private key is invalid key.  Double check' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).not_to be_success
      end

      describe 'message' do
        subject { res.body }

        it 'has metadata' do
          expect(subject['message']).to eql message
        end
      end
    end
  end

  describe 'unfollow' do
    context 'successfully' do
      let(:res) { new_project.unfollow }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'message' do
        subject { res.body }

        it 'has metadata' do
          expect(subject).to be_instance_of(Hash)
          expect(subject['followed']).to be_falsy
        end
      end
    end
  end
end
