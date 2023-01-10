class UrlLink < ApplicationRecord
  validates_presence_of :url
  validates :url, format: URI::regexp(%w[http https])
  validates_uniqueness_of :slug
  validates_length_of :url, within: 3..255, on: :create, message: "too long"
  validates_length_of :slug, within: 3..255, on: :create, message: "too long"

  def short
    Rails.application.routes.url_helpers.short_url(slug: self.slug)
  end
  before_validation :generate_slug
  
def generate_slug
  self.slug = SecureRandom.uuid[0..5] if self.slug.nil? || self.slug.empty?
  true
end
end
