# frozen_string_literal: true


require_relative '../../../domain/language'

class SpanishLanguage < Language
  def initialize(spanish)
    @spanish = spanish
  end

  def good_morning
    @spanish.morning
  end

  def good_night
    @spanish.night
  end
end

