# frozen_string_literal: true
require 'spec_helper'

RSpec.describe CircleCi::Project, :vcr do
  let(:project) { described_class.new 'github', 'mtchavez', 'circleci' }

  xdescribe 'all' do
    context 'successfully' do
      let(:res) { described_class.all }

      xit 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'projects' do
        subject { res.body }

        it 'has metadata' do
          expect(subject).to be_instance_of(Array)
          expect(subject.size).to eql 1
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
      let(:res) { project.build 'master' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'build' do
        subject { res.body }

        it 'returns newly created build' do
          expect(subject).to be_instance_of(Hash)
          expect(subject['branch']).to eql 'master'

          expect(subject).to have_key 'messages'
          expect(subject).to have_key 'start_time'
          expect(subject).to have_key 'stop_time'
          expect(subject).to have_key 'status'
          expect(subject).to have_key 'subject'
        end
      end
    end

    context 'with build parameters' do
      let(:params) { { 'ABC' => '123'} }
      let(:res) { project.build 'master', 'build_parameters' => params }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'build' do
        subject { res.body }

        it 'returns newly created build' do
          expect(subject).to be_instance_of(Hash)
          expect(subject['branch']).to eql 'master'
          expect(subject).to have_key 'build_parameters'
          expect(subject['build_parameters']).to eq params
        end
      end
    end
  end

  describe 'clear_cache' do
    context 'successfully' do
      let(:res) { project.clear_cache }

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

  xdescribe 'delete_checkout_key' do
    context 'successfully' do
      let(:res) { project.delete_checkout_key(test_delete_checkout_key_fingerprint) }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
        expect(res.body).to be_instance_of(Hash)
        expect(res.body['message']).to eql 'ok'
      end
    end

    context 'unsuccessfully' do
      let(:res) { project.delete_checkout_key 'asdf-bogus' }
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
      let(:res) { project.get_checkout_key test_checkout_key_fingerprint }

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
      let(:res) { project.get_checkout_key 'asdf-bogus' }
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
      let(:res) { project.list_checkout_keys }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'keys' do
        subject(:keys) { res.body }

        it 'are returned' do
          expect(subject).to be_instance_of(Array)
          expect(subject.size).to eql 2
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
    xcontext 'successfully' do
      let(:res) { project.new_checkout_key 'deploy-key' }

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
      let(:project) { described_class.new('github', 'github', 'hub') }
      let(:res) { project.new_checkout_key 'deploy-key' }
      let(:message) { 'Project not found' }

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
      let(:res) { project.recent_builds }

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
            expect(subject['committer_name']).to eql 'Chavez'
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
          let(:res) { project.recent_builds limit: 5 }

          it 'is verified by response' do
            expect(res).to be_instance_of(CircleCi::Response)
            expect(res).to be_success
          end

          it 'returns correct total of builds' do
            expect(res.body.size).to eql 5
          end
        end

        context 'filter' do
          let(:res) { project.recent_builds limit: 5, filter: 'failed' }

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
      let(:res) { project.recent_builds_branch 'master' }

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
            expect(subject['committer_name']).to eql 'Chavez'
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
      let(:res) { project.add_ssh_key test_rsa_private_key, 'hostname' }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end
    end

    context 'unsuccessfully' do
      let(:res) { project.add_ssh_key 'RSA Private Key', 'hostname' }
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

  xdescribe 'enable' do
    context 'successfully' do
      # note the change in project
      let(:project) { described_class.new('github', 'mtchavez', 'dotfiles') }
      let(:res) { project.enable }

      it 'is verified by response' do
        expect(res).to be_instance_of(CircleCi::Response)
        expect(res).to be_success
      end

      describe 'project' do
        let(:res) { project.list_checkout_keys }
        subject { res.body }

        it 'returns the circleci project settings' do
          expect(subject).to be_instance_of(Array)
          expect(subject.first).to have_key('public_key')
          expect(subject.first['type']).to eql('deploy-key')
        end
      end
    end
  end

  xdescribe 'follow' do
    context 'successfully' do
      let(:res) { project.follow }

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

  # describe 'unfollow' do
  #   context 'successfully' do
  #     let(:res) { project.unfollow }
  #
  #     it 'is verified by response' do
  #       expect(res).to be_instance_of(CircleCi::Response)
  #       expect(res).to be_success
  #     end
  #
  #     describe 'message' do
  #       subject { res.body }
  #
  #       it 'has metadata' do
  #         expect(subject).to be_instance_of(Hash)
  #         expect(subject['followed']).to be_falsy
  #       end
  #     end
  #   end
  # end

  describe 'settings' do
    context 'successfully' do
      let(:res) { project.settings}

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

  describe 'list_envvars' do
    context 'successfully' do
      let(:res) { project.list_envvars }

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
  end

  describe 'set_envvars' do
    context 'successfully' do
      let(:testvar) { CircleCi::Envvar.new(name: 'TESTENV', value: 'testvalue') }
      let(:res) { project.set_envvar(testvar) }

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
  end
end
