# frozen_string_literal: true

RSpec.shared_examples 'a successful response' do
  it 'is a response object' do
    expect(res).to be_instance_of(CircleCi::Response)
  end

  it 'is success' do
    expect(res).to be_success
  end
end
