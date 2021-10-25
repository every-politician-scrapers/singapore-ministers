#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      noko.css('.field-content').text.tidy
    end

    def position
      noko.css('.qna').text.tidy
          .split(/ and (?=Coordinating Minister)/)
          .flat_map { |posn| posn.split(/ and (?=Second Minister)/) }
          .flat_map { |posn| posn.split(/, (?=Second Minister)/) }
          .flat_map { |posn| posn.split(/ and (?=Minister)/) }
          .map(&:tidy)
    end
  end

  class Members
    def member_container
      noko.css('.view-content li')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
