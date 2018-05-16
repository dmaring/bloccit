class Post < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent:(:destroy)

  default_scope { order('created_at DESC') }

  scope :order_by_title, -> { order('title ASC') }

  # # the above could also be written
  # def self.ordered_by_title
  #   order('title DESC')
  # end


  scope :order_by_reverse_created_at, -> { order('created_at ASC') }

  # the above could also be written
  # def self.ordered_by_reverse_created_at
  #   order('created_at ASC')
  # end


  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true
end
