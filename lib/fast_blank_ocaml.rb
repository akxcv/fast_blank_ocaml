# frozen_string_literal: true

require_relative 'cowcaml.rb'

class String
  def blank?
    Cowcaml::Base.blank self
  end
end
