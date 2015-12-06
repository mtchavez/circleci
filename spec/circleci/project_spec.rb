require 'spec_helper'

describe CircleCi::Project do

  describe 'all' do

    context 'successfully', vcr: { cassette_name: 'project/all/success', record: :none } do

      let(:res) { CircleCi::Project.all }

      it 'returns a response object' do
        res.should be_an_instance_of(CircleCi::Response)
        res.should be_success
      end

      it 'returns all projects' do
        res.body.should be_an_instance_of(Array)
        res.body.size.should eql 145
        res.body.each do |project|
          project.should have_key('default_branch')
          project.should have_key('vcs_url')
        end
      end

    end

  end

  describe 'build' do

    context 'successfully', vcr: { cassette_name: 'project/build/success', record: :none } do

      let(:res) { CircleCi::Project.build 'Shopify', 'google_auth' }

      it 'returns a response object' do
        res.should be_an_instance_of(CircleCi::Response)
        res.should be_success
      end

      it 'returns newly created build' do
        res.body.should be_an_instance_of(Hash)
        build = res.body
        build['committer_name'].should eql 'Francois Chagnon'
        build['branch'].should eql 'master'

        build.should have_key 'messages'
        build.should have_key 'start_time'
        build.should have_key 'stop_time'
        build.should have_key 'status'
        build.should have_key 'subject'
      end

    end

  end

  describe 'build_branch' do

    context 'successfully', vcr: { cassette_name: 'project/build_branch/success', record: :none } do

      let(:res) { CircleCi::Project.build_branch 'ad2games', 'soapy_cake', 'master' }

      it 'returns a response object' do
        res.should be_an_instance_of(CircleCi::Response)
        res.should be_success
      end

      it 'returns newly created build' do
        res.body.should be_an_instance_of(Hash)
        build = res.body
        build['committer_name'].should eql 'Harald Wartig'
        build['branch'].should eql 'master'

        build.should have_key 'messages'
        build.should have_key 'start_time'
        build.should have_key 'stop_time'
        build.should have_key 'status'
        build.should have_key 'subject'
      end

      it 'can use experimental API for Build Parameters' do
        res = CircleCi::Project.build_branch 'ad2games', 'soapy_cake', 'master', 'SOME_VAR' => '123'

        res.should be_success
      end

    end

  end

  describe 'recent_builds' do

    context 'successfully', vcr: { cassette_name: 'project/recent_builds/success', record: :none } do

      let(:res) { CircleCi::Project.recent_builds 'mtchavez', 'rb-array-sorting' }

      it 'returns a response object' do
        res.should be_an_instance_of(CircleCi::Response)
        res.should be_success
      end

      it 'returns all projects' do
        res.body.should be_an_instance_of(Array)
        res.body.size.should eql 1
        build = res.body.first
        build['committer_name'].should eql 'Chavez'
        build.should have_key 'messages'
        build.should have_key 'start_time'
        build.should have_key 'stop_time'
        build.should have_key 'status'
        build.should have_key 'subject'

        user = build['user']
        user['is_user'].should be
        user['login'].should eql 'mtchavez'
      end

    end

    context 'non-utf8 encoding', vcr: { cassette_name: 'project/recent_builds/encoding', serialize_with: :json, record: :none } do

      let(:res) { CircleCi::Project.recent_builds 'mtchavez', 'encoding' }

      it 'JSON parsed correctly' do
        res.should be_success
        res.body.should be_an_instance_of(Array)
        res.body.size.should eql 1
      end

    end

  end

  describe 'recent_builds_branch' do

    context 'successfully', vcr: { cassette_name: 'project/recent_builds_branch/success', record: :none } do

      let(:res) { CircleCi::Project.recent_builds_branch 'mtchavez', 'rb-array-sorting', 'master' }

      it 'returns a response object' do
        res.should be_an_instance_of(CircleCi::Response)
        res.should be_success
      end

      it 'returns all projects for a branch' do
        res.body.should be_an_instance_of(Array)
        res.body.size.should eql 5
        build = res.body.first
        build['committer_name'].should eql 'Chavez'
        build.should have_key 'messages'
        build.should have_key 'start_time'
        build.should have_key 'stop_time'
        build.should have_key 'status'
        build.should have_key 'subject'

        user = build['user']
        user['is_user'].should be
        user['login'].should eql 'mtchavez'
      end

    end

  end

  describe 'ssk_key' do

    context 'successfully', vcr: { cassette_name: 'project/ssh_key/success', record: :all } do

      it 'returns a response object' do
        res = CircleCi::Project.ssh_key 'mtchavez', 'circleci', 'RSA Private Key', 'hostname'
        res.should be_an_instance_of(CircleCi::Response)
        res.should be_success
      end

    end

  end

  describe 'clear_cache' do

    context 'successfully', vcr: { cassette_name: 'project/clear_cache/success', record: :none } do

      let(:res) { CircleCi::Project.clear_cache 'mtchavez', 'rb-array-sorting' }

      it 'returns a response object' do
        res.should be_an_instance_of(CircleCi::Response)
        res.should be_success
      end

      it 'returns all projects' do
        res.body.should be_an_instance_of(Hash)
        res.body['status'].should eql 'build caches deleted'
      end

    end

  end

  describe 'enable' do

    context 'successfully', vcr: { cassette_name: 'project/enable/success', record: :none } do

      let(:res) { CircleCi::Project.enable 'Shopify', 'google_auth' }

      it 'returns a response object' do
        res.should be_an_instance_of(CircleCi::Response)
        res.should be_success
      end

      it 'returns the circleci project settings' do
        res.body.should be_an_instance_of(Hash)
        project = res.body
        project['has_usable_key'].should eql true
        project['github_permissions'].should be_an_instance_of(Hash)
        project['github_permissions']['admin'].should eql true
        project['github_permissions']['push'].should eql true
        project['github_permissions']['pull'].should eql true

        project.should have_key 'branches'
      end

    end

  end

  describe 'follow' do

    context 'successfully', vcr: { cassette_name: 'project/follow/success', record: :none } do

      let(:res) { CircleCi::Project.follow 'Shopify', 'google_auth' }

      it 'returns a response object' do
        res.should be_an_instance_of(CircleCi::Response)
        res.should be_success
      end

      it 'returns a response hash' do
        res.body.should be_an_instance_of(Hash)
        response = res.body
        response.should have_key 'followed'
        response['followed'].should eql true
      end

    end

  end

  describe 'unfollow' do

    context 'successfully', vcr: { cassette_name: 'project/unfollow/success', record: :none } do

      let(:res) { CircleCi::Project.unfollow 'Shopify', 'google_auth' }

      it 'returns a response object' do
        res.should be_an_instance_of(CircleCi::Response)
        res.should be_success
      end

      it 'returns a response hash' do
        res.body.should be_an_instance_of(Hash)
        response = res.body
        response.should have_key 'followed'
        response['followed'].should eql false
      end

    end

  end

  describe 'settings' do

    context 'successfully', vcr: { cassette_name: 'project/settings/success', record: :none } do

      let(:res) { CircleCi::Project.settings 'Shopify', 'google_auth' }

      it 'returns a response object' do
        res.should be_an_instance_of(CircleCi::Response)
        res.should be_success
      end

      it 'returns a response hash' do
        res.body.should be_an_instance_of(Hash)
        project = res.body
        project.should have_key 'github_permissions'
        project.should have_key 'branches'
        project.should have_key 'default_branch'
      end

    end

  end

  describe 'checkout_keys' do

    context 'successfully', vcr: { cassette_name: 'project/checkout_keys/success', record: :once } do

      let(:res) { CircleCi::Project.checkout_keys 'shwetakale', 'recipe_guru' }

      it 'returns a response object' do
        res.should be_an_instance_of(CircleCi::Response)
        res.should be_success
      end

      it 'returns a response hash' do
        res.body.should be_an_instance_of(Array)
        project = res.body[0]
        project.should have_key 'public_key'
        project.should have_key 'type'
        project.should have_key 'fingerprint'
      end

    end

  end

end
