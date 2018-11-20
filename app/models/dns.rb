class Dns < ApplicationRecord
  validates :ip, presence: true
  validates :domains, presence: true
end
