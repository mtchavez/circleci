require 'spec_helper'

describe CircleCi::Build do

  describe 'artifacts' do

    context 'successfully', vcr: { cassette_name: 'build/artifacts/success', record: :none } do

      let(:res) { CircleCi::Build.artifacts 'janstenpickle', 'logback-flume', 2 }

      it 'returns a response object' do
        res.should be_an_instance_of(CircleCi::Response)
        res.should be_success
      end

      it 'returns all artifacts for build' do
        res.body.should be_an_instance_of(Array)

        artifacts = res.body
        artifacts.size.should eql 2
        artifacts.first.should be_an_instance_of(Hash)

        artifact = artifacts.first
        artifact.should have_key 'url'
        artifact.should have_key 'node_index'
        artifact.should have_key 'pretty_path'
        artifact.should have_key 'path'
      end

    end

  end

  describe 'cancel' do

    context 'successfully', vcr: { cassette_name: 'build/cancel/success', record: :none } do

      let(:res) do
        CircleCi::Build.cancel 'Shopify', 'spy', 572
      end

      it 'returns a response object' do
        res.should be_an_instance_of(CircleCi::Response)
        res.should be_success
      end

      it 'returns a canceled build' do
        res.body.should be_an_instance_of(Hash)
        build = res.body
        build['status'].should eql 'canceled'
        build['outcome'].should eql 'canceled'
        build['canceled'].should eql true
      end

    end

  end

  describe 'get' do

    context 'successfully', vcr: { cassette_name: 'build/get/success', record: :none } do

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

    context 'successfully', vcr: { cassette_name: 'build/retry/success', record: :none } do

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

  describe 'tests' do

    context 'successfully', vcr: { cassette_name: 'build/tests/success', record: :none } do

      let(:res) { CircleCi::Build.tests 'mtchavez', 'circleci', 29 }

      it 'returns a response object' do
        res.should be_an_instance_of(CircleCi::Response)
        res.should be_success
      end

      it 'returns all artifacts for build' do
        res.body.should be_an_instance_of(Hash)

        tests = res.body['tests']
        tests.size.should eql 39
        tests.first.should be_an_instance_of(Hash)

        test = tests.first
        test.should have_key 'file'
        test.should have_key 'source'
        test.should have_key 'result'
      end

    end

  end

end
