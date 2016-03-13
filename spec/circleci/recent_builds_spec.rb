require 'spec_helper'

describe CircleCi::RecentBuilds do
  describe 'get' do
    context 'successfully', vcr: { cassette_name: 'recent_builds/get/success', record: :none } do
      let(:res) { CircleCi::RecentBuilds.get }

      it 'returns a response object' do
        res.should be_an_instance_of(CircleCi::Response)
        res.should be_success
      end

      it 'returns recent builds' do
        res.body.should be_an_instance_of(Array)

        builds = res.body
        builds.size.should eql 30
        builds.first.should be_an_instance_of(Hash)

        build = builds.first
        build.should have_key 'build_num'
        build.should have_key 'build_url'
        build.should have_key 'status'
      end

      describe 'with limit' do
        let(:res) { CircleCi::RecentBuilds.get limit: 3 }

        it 'returns correct total of builds' do
          builds = res.body
          builds.size.should eql 3
        end
      end
    end
  end
end
