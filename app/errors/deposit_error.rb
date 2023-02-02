# frozen_string_literal: true

class DepositError < StandardError
  def http_status
    422
  end

  def code
    'unprocessable_entity'
  end
end
