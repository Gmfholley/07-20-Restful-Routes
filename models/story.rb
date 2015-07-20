class Story < ActiveRecord::Base
  validates :name, presence: true
  validate :user, presence: true
end