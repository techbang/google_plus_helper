require "google_plus_helper/helper"

module GooglePlusHelper #:nodoc: all
  class Railtie < Rails::Railtie
    initializer "google_plus_helper.view_helpers" do
      ActionView::Base.send :include, GooglePlusHelper
    end
  end
end