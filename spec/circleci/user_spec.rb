require 'spec_helper'

describe CircleCi::User do

  describe 'me' do

    context 'successfully' do

      use_vcr_cassette 'user/me/success', :record => :none

      it 'returns a response object' do
        res = CircleCi::User.me
        res.should be_an_instance_of(CircleCi::Response)
        res.should be_success
      end

      it 'returns my data' do
        res = CircleCi::User.me
        res.body['login'].should eql 'mtchavez'
        res.body['admin'].should be_false
      end

    end

  end

end
