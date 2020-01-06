# frozen_string_literal: true

RSpec.shared_examples 'an unsuccessful response' do
  it 'is a response object' do
    expect(res).to be_instance_of(CircleCi::Response)
  end

  it 'is not a success' do
    expect(res).not_to be_success
  end
end
