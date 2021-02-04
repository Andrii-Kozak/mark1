class UserPolicy < ApplicationPolicy
  %w[destroy? edit? update?].each do |action|
    define_method(action) do
      user.admin? || user.id == record.id
    end
  end
end
