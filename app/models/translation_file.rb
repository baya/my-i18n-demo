# encoding: utf-8
class TranslationFile

  attr_reader :errors

  Spreadsheet.client_encoding = 'UTF-8'

  def self.load_to_backend(file)
    file = new(file)
    file.to_backend
    file.errors
  end

  def initialize(file)
    @file   = file
    @errors = []    
  end

  def to_backend
    dict.each {|locale, value|
      I18n.backend.store_translations(locale, value, escape: false)
    }
  rescue Exception => e
    Rails.logger.info(e.message)
    Rails.logger.info(e.backtrace.join("\n"))
    @errors << [e.class, e.message]
  end


  private
  
  def book
    @book ||= Spreadsheet.open(@file)
  end

  def sheet
    @sheet ||= book.worksheet(0)
  end

  def dict
    if @dict.nil?
      @dict = {}
      sheet.each do |row|
        locale, key, _, value = row
        locale = locale.gsub(/\s/, '')
        key = key.gsub(/\s/, '')

        @dict[locale] ||= {}
        @dict[locale][key] = value
      end
    end

    @dict
  end

end
