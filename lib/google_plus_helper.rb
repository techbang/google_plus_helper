require 'google_plus_helper/settings'

module GooglePlusHelper #:nodoc: all
  class << self
    def settings
      @_settings ||= Settings.new
      @_settings
    end
  end

  module Rails
    if ::Rails.version < "3.1"
      require "google_plus_helper/railtie"
    else
      require "google_plus_helper/engine"
    end
  end

  def self.config
    yield(settings)
  end
end
