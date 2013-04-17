require 'spec_helper'

describe CircleCi::Project do

  describe 'all' do

    context 'successfully' do

      use_vcr_cassette 'project/all/success', :record => :none

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

  describe 'recent_builds' do

    context 'successfully' do

      use_vcr_cassette 'project/akk/success', :record => :none

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

  end

  describe 'clear_cache' do

    context 'successfully' do

      use_vcr_cassette 'project/clear_cache/success', :record => :none

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

end
