require 'spec_helper'

describe CircleCi::User do
  describe 'me' do
    context 'successfully', vcr: { cassette_name: 'user/me/success', record: :none } do
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

  describe 'heroku-key' do
    context 'successfully',  vcr: { cassette_name: 'user/heroku-key/success', record: :none } do
      it 'returns a response object' do
        res = CircleCi::User.heroku_key test_heroku_key
        res.should be_an_instance_of(CircleCi::Response)
        res.should be_success
      end
    end
  end
end
