class ShortenedUrl < ApplicationRecord
    UNIQUE_ID_LENGTH = 6
    validates :orgiginal_url, presence: true, on: :create
    
    before_create :generate_short_url
    before_create :sanitize

    def generate_short_url
        url = ([*('a'..'z'),*('0'..'9')]).sample(UNIQUE_ID_LENGTH).join
        old_url = ShortenedUrl.where(short_url: url).last
        if old_url.present?
            self.generate_short_url
        else
            self.short_url = url
        end

    end

    def find_duplicate
        ShortenedUrl.find_by_sanitize_url(self.sanitize_url)
    end

    def new_url?
        find_duplicate.nil?
    end

    def sanitize
        self.orgiginal_url.strip!
        self.sanitize_url = self.orgiginal_url.downcase.gsub(/(https?:\/\/)|(www\.)/,"")
        self.sanitize_url = "http://#{self.sanitize_url}"
    end
end
