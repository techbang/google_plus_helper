module GooglePlusHelper #:nodoc: all
  class Settings
    attr_accessor :social_plugin_version

    def initialize
      self.social_plugin_version = :html5
    end

  end
end