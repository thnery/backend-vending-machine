# frozen_string_literal: true

module UserRole
  def buyer?
    @current_user.buyer?
  end

  def seller?
    @current_user.seller?
  end

end
