require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_cards = doc.css(".student-card a")
    student_cards.collect do |element|
      {
        :name => element.css(".student-name").text,
        :location => element.css(".student-location").text,
        :profile_url => element.attr('href')
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nkogiri::HTML(html)
    return_hash = {}

      social = doc.css("vitals-container.social-icon-container a")
      social.each do |element|
        if element.attr('href').include?("twitter")
          return_hash[:twitter] = element_attr('href')
        elsif element.attr('href').include?("linkedin")
          return_hash[:linkedin] = element_attr('href')
        elsif element.attr('href').include?("github")
          return_hash[:github] = element_attr('href')
        elsif element.attr('href').end_with?("com/")
          return_hash[:blog] = element_attr('href')
        end
      end
      return_hash[:profile_quote] = doc.css(".vitals-container .vitals-text-container .profile-quote").text
      return_hash[:bio] = doc.css(".bio-block.details-block .bio-content.content-holder .description-holder p").text

      return_hash
    end
end
