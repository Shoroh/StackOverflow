# User can ask a questions. All questions store in this model.
class Question < ActiveRecord::Base
  # Questions should have the owner.
  belongs_to :user, counter_cache: :questions_count
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy
  include Votable

  validates :title, :body, presence: true

  validates :title, length: 20..255
  validates :body, length: 20..6000

  # Questions could have flags:
  enum status: { active: 0, pending: 1, deleted: 2 }

  # Quantity questions per page by default (last 10)
  paginates_per 10

  # Stats. Used to know how many unique IP_address have seen the page.
  #   Uses impressions_count field in :questions table to cache counter.
  is_impressionable counter_cache: true, column_name: :unique_views, unique: :all

  # Tags
  acts_as_taggable

  def sorted_by_abc_tags
    @tags ||= tags.sort_by {|a| a.name}
  end

  default_scope -> { includes([:tags, :user, :answers]).order(created_at: :desc) }

  scope :recent, -> { active }
  scope :oldest, -> { recent.unscope(:order).active.order(created_at: :asc) }
  scope :featured, -> { recent.where(featured: true) }
  scope :popular, -> { recent.unscope(:order).active.order(unique_views: :desc) }
  scope :unanswered, -> { recent.where("answers_count = '0'") }

end
