# frozen_string_literal: true
require 'spec_helper'

RSpec.describe CircleCi::Project, :vcr do
  describe 'all' do
    context 'successfully' do
      let(:res) { described_class.all }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'projects' do
        subject { res.body }

        it 'has metadata' do
          expect(subject).to be_instance_of(Array)
          expect(subject.size).to eql 2
          subject.each do |project|
            expect(project).to have_key('default_branch')
            expect(project).to have_key('vcs_url')
          end
        end
      end
    end
  end

  describe 'build' do
    context 'successfully' do
      let(:res) { described_class.build 'mtchavez', 'circleci' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'build' do
        subject { res.body }

        it 'has metadata' do
          expect(subject).to be_instance_of(Hash)
          expect(subject['committer_name']).to eql 'GitHub'
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
      let(:res) { described_class.build_branch 'mtchavez', 'circleci', 'master' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'build' do
        subject { res.body }

        it 'returns newly created build' do
          expect(subject).to be_instance_of(Hash)
          expect(subject['committer_name']).to eql 'GitHub'
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
      let(:res) { described_class.build_branch 'mtchavez', 'circleci', 'master', 'SOME_VAR' => '123' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end
    end
  end

  describe 'build_ssh_key' do
    context 'successfully' do
      let(:res) { described_class.build_ssh_key 'mtchavez', 'circleci', '65', 'RSA Private Key', 'hostname' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end
    end
  end

  describe 'delete_checkout_key' do
    context 'successfully' do
      let(:res) { described_class.delete_checkout_key 'mtchavez', 'circleci', test_delete_checkout_key_fingerprint }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
        expect(res.body).to be_instance_of(Hash)
        expect(res.body['message']).to eql 'ok'
      end
    end

    context 'unsuccessfully' do
      let(:res) { described_class.delete_checkout_key 'mtchavez', 'circleci', 'asdf-bogus' }
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

  describe 'get_checkout_key' do
    context 'successfully' do
      let(:res) { described_class.get_checkout_key 'mtchavez', 'circleci', test_checkout_key_fingerprint }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'key' do
        subject { res.body }

        it 'has metadata' do
          expect(subject).to be_instance_of(Hash)
          expect(subject['public_key']).to match(/^ssh-rsa/)
          expect(subject['type']).to eql 'deploy-key'
          expect(subject['fingerprint']).to eql test_checkout_key_fingerprint
        end
      end
    end

    context 'unsuccessfully' do
      let(:res) { described_class.get_checkout_key 'mtchavez', 'circleci', 'asdf-bogus' }
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
      let(:res) { described_class.list_checkout_keys 'mtchavez', 'circleci' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'keys' do
        subject(:keys) { res.body }

        it 'are returned' do
          expect(subject).to be_instance_of(Array)
          expect(subject.size).to eql 5
        end

        context 'first key' do
          subject { keys.first }

          it 'has metadata' do
            expect(subject).to be_instance_of(Hash)
            expect(subject).to have_key 'public_key'
            expect(subject).to have_key 'type'
            expect(subject).to have_key 'fingerprint'
          end
        end
      end
    end
  end

  describe 'new_checkout_key' do
    context 'successfully' do
      let(:res) { described_class.new_checkout_key 'mtchavez', 'circleci', 'deploy-key' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'key' do
        subject { res.body }

        it 'has metadata' do
          expect(subject).to be_instance_of(Hash)
          expect(subject['public_key']).to match(/^ssh-rsa/)
          expect(subject['type']).to eql 'deploy-key'
          expect(subject).to have_key 'fingerprint'
        end
      end
    end

    context 'unsuccessfully' do
      let(:res) { described_class.new_checkout_key 'github', 'hub', 'deploy-key' }
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
      let(:res) { described_class.recent_builds 'mtchavez', 'circleci' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'projects' do
        subject(:projects) { res.body }

        it 'are returned in a list' do
          expect(subject).to be_instance_of(Array)
          expect(subject.size).to eql 30
        end

        describe 'first project' do
          subject { projects.first }

          it 'has metadata' do
            expect(subject['committer_name']).to eql 'GitHub'
            expect(subject).to have_key 'messages'
            expect(subject).to have_key 'start_time'
            expect(subject).to have_key 'stop_time'
            expect(subject).to have_key 'status'
            expect(subject).to have_key 'subject'
          end
        end
      end

      describe 'params' do
        context 'limit' do
          let(:res) { described_class.recent_builds 'mtchavez', 'circleci', limit: 5 }

          it 'is verified by response' do
            expect(res).to be_instance_of(CircleCi::Response)
            expect(res).to be_success
          end

          it 'returns correct total of builds' do
            expect(res.body.size).to eql 5
          end
        end

        context 'filter' do
          let(:res) { described_class.recent_builds 'mtchavez', 'circleci', limit: 5, filter: 'failed' }

          it 'is verified by response' do
            expect(res).to be_instance_of(CircleCi::Response)
            expect(res).to be_success
          end

          it 'returns builds filtered by status' do
            builds = res.body
            statuses = builds.map { |build| build['status'] }
            statuses.each { |status| expect(status).to eql('failed') }
          end
        end
      end
    end
  end

  describe 'recent_builds_branch' do
    context 'successfully' do
      let(:res) { described_class.recent_builds_branch 'mtchavez', 'circleci', 'master' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'projects' do
        subject(:projects) { res.body }

        it 'are returned in a list' do
          expect(subject).to be_instance_of(Array)
          expect(subject.size).to eql 30
        end

        describe 'first project' do
          subject { projects.first }

          it 'has metadata' do
            expect(subject['committer_name']).to eql 'GitHub'
            expect(subject).to have_key 'messages'
            expect(subject).to have_key 'start_time'
            expect(subject).to have_key 'stop_time'
            expect(subject).to have_key 'status'
            expect(subject).to have_key 'subject'
          end
        end
      end
    end
  end

  describe 'ssh_key' do
    context 'successfully' do
      let(:res) { described_class.ssh_key 'mtchavez', 'circleci', test_rsa_private_key, 'hostname' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end
    end

    context 'unsuccessfully' do
      let(:res) { described_class.ssh_key 'mtchavez', 'circleci', 'RSA Private Key', 'hostname' }
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

  describe 'clear_cache' do
    context 'successfully' do
      let(:res) { described_class.clear_cache 'mtchavez', 'circleci' }

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

  describe 'enable' do
    context 'successfully' do
      let(:res) { described_class.enable 'mtchavez', 'circleci' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'project' do
        subject { res.body }

        it 'returns the circleci project settings' do
          expect(subject).to be_instance_of(Hash)
          expect(subject['has_usable_key']).to be_truthy
          expect(subject).to have_key 'branches'
        end
      end
    end
  end

  describe 'follow' do
    context 'successfully' do
      let(:res) { described_class.follow 'mtchavez', 'circleci' }

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

  describe 'unfollow' do
    context 'successfully' do
      let(:res) { described_class.unfollow 'mtchavez', 'circleci' }

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

  describe 'settings' do
    context 'successfully' do
      let(:res) { described_class.settings 'mtchavez', 'circleci' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'project' do
        subject { res.body }

        it 'has metadata' do
          expect(subject).to be_instance_of(Hash)
          expect(subject).to have_key 'vcs-type'
          expect(subject).to have_key 'branches'
          expect(subject).to have_key 'default_branch'
        end
      end
    end
  end

  describe 'envvar' do
    context 'successfully' do
      let(:res) { described_class.envvar 'mtchavez', 'circleci' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'envvars' do
        subject(:envvars) { res.body }

        it 'has list' do
          expect(subject).to be_instance_of(Array)
          expect(subject.size).to eql 2
        end

        context 'first envvar' do
          subject { envvars.first }

          it 'returns a response hash' do
            expect(subject).to have_key 'name'
            expect(subject).to have_key 'value'
          end
        end
      end
    end

    context 'unsuccessfully' do
      let(:res) { described_class.envvar 'mtchavez', 'asdf-bogus' }
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

    context 'envvars deprecation' do
      let(:res) { described_class.envvars 'mtchavez', 'circleci' }
      let(:deprecated_message) do
        '\[Deprecated\] Project#envvars is deprecated please use Project#envvar'
      end

      it 'logs warning' do
        expect { res }.to output(/#{deprecated_message}/).to_stdout_from_any_process
      end
    end
  end

  describe 'set_envvar' do
    context 'successfully' do
      let(:res) { described_class.set_envvar 'mtchavez', 'circleci', name: 'TESTENV', value: 'testvalue' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'envvar' do
        subject { res.body }

        it 'has metadata' do
          expect(subject['name']).to eq 'TESTENV'
          # obfuscated value
          expect(subject['value']).to eq 'xxxxalue'
        end
      end
    end

    context 'unsuccessfully' do
      let(:res) { described_class.set_envvar 'mtchavez', 'asdf-bogus', name: 'TESTENV', value: 'testvalue' }
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
end
