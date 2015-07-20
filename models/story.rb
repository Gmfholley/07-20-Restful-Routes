class Story < ActiveRecord::Base
  validates :name, presence: true
  validates :user, presence: true
  belongs_to :user
end