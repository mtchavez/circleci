# frozen_string_literal: true

def test_heroku_key
  ENV.fetch('HEROKU_TOKEN', '01234567-89ab-cdef-0123-456789abcdef')
end
