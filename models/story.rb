class Story < ActiveRecord::Base
  validates :name, presence: true
  validate :user, presence: true
  belongs_to :user
end