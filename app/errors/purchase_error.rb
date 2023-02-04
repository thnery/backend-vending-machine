# frozen_string_literal: true

class PurchaseError < StandardError
  def http_status
    422
  end

  def code
    'unprocessable_entity'
  end
end
