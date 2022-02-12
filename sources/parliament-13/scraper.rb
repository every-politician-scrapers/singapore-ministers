#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class OfficeholderList < OfficeholderListBase
  decorator RemoveReferences
  decorator UnspanAllTables
  decorator WikidataIdsDecorator::Links

  def holder_entries
    noko.css('.navbox-columns-table .navbox-list-with-group li')
  end

  class Officeholder < OfficeholderBase
    def name_cell
      noko
    end

    def itemLabel
      name_cell.css('a/@title').map(&:text).first.to_s.gsub(/\(.*?\)/, '').tidy
    end

    def startDate
      '2016-01-15'
    end

    def endDate
      "2020-06-23"
    end
  end
end

url = ARGV.first
puts EveryPoliticianScraper::ScraperData.new(url, klass: OfficeholderList).csv
