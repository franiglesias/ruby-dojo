# frozen_string_literal: true


require_relative '../../../domain/language'

class EnglishLanguage < Language
  def initialize(english)
    @english = english
  end

  def good_morning
    @english.wakeup
  end

  def good_night
    @english.bed
  end
end

