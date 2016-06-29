class Idea < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true

  default_scope { order(created_at: :desc) }
  enum quality: %w(swill plausible genius)

end
