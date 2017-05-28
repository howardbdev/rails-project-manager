class User < ApplicationRecord
  has_secure_password
  enum role: [:worker, :supervisor, :admin]
end
