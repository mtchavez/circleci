require 'spec_helper'

describe CircleCi::Build do

  describe 'get' do

    context 'successfully' do

      use_vcr_cassette 'build/get/success', :record => :none

      let(:res) { CircleCi::Build.get 'mtchavez', 'rb-array-sorting', 1 }

      it 'returns a response object' do
        res.should be_an_instance_of(CircleCi::Response)
        res.should be_success
      end

      it 'returns all projects' do
        res.body.should be_an_instance_of(Hash)
        build = res.body
        build.should have_key 'committer_name'
        build.should have_key 'messages'
        build.should have_key 'start_time'
        build.should have_key 'stop_time'
        build.should have_key 'status'
        build.should have_key 'subject'
      end

    end

  end

  describe 'retry' do

    context 'successfully' do

      use_vcr_cassette 'build/retry/success', :record => :none

      let(:res) { CircleCi::Build.retry 'mtchavez', 'rb-array-sorting', 1 }

      it 'returns a response object' do
        res.should be_an_instance_of(CircleCi::Response)
        res.should be_success
      end

      it 'returns all projects' do
        res.body.should be_an_instance_of(Hash)
        build = res.body
        build['status'].should eql 'queued'
        build.should have_key 'committer_name'
        build.should have_key 'messages'
        build.should have_key 'start_time'
        build.should have_key 'stop_time'
        build.should have_key 'subject'
      end

    end

  end

end
