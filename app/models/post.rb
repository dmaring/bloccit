class Post < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent:(:destroy)
  after_create :create_vote


  has_many :votes, dependent:(:destroy)

  default_scope { order('rank DESC') }

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

  # count the number of up_votes (votes implies self.votes)
  def up_votes
    votes.where(value: 1).count
  end
  # count the number of down_votes
  def down_votes
    votes.where(value: -1).count
  end
  # sum the values (1 or -1) of every vote
  def points
    votes.sum(:value)
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end

  def create_vote
    user.votes.create(value: 1, post: self)
  end
end
