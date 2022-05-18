# frozen_string_literal: true

def test_rsa_private_key
  File.read(File.expand_path("#{File.dirname(__FILE__)}/test_rsa"))
end
