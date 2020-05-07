class User < ApplicationRecord
  has_many :tasks, dependent: :restrict_with_error
end
