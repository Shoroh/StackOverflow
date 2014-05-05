class Question < ActiveRecord::Base

  # Questions should have the owner.
  belongs_to :user, counter_cache: true

  validates :title, :body, :presence => true

  validates :title, length: 20..255
  validates :body, length: 20..6000

  # Questions could have flags:
  enum status: {
      active:       0,
      pending:      1,
      deleted:      2
  }

  # Generate last recent questions:
  scope :recent, -> { active.order(created_at: :desc) }

  # Quantity questions per page by default (last 10)
  paginates_per 10

  # Stats. Used to know how many unique IP_address have seen the page.
  #   Uses impressions_count field in :questions table to cache counter.
  is_impressionable :counter_cache => true, column_name: :unique_views, unique: :all

end
