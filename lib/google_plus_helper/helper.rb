# GooglePlusHelper helps you generate Google Plus Social Plugins in your Rails application.
#
# See README.md for usage.
#
# By default it renders HTML5 version. To switch to XML version, specify the version explicitly in initializer:
#
#   # config/initializers/google_plus_helper.rb
#   GooglePlusHelper.config do |config|
#     config.social_plugin_version = :xml
#   end
module GooglePlusHelper
  # Generates a <tt><script></tt> tag to load Google Plusone JavaScript file.
  #
  # The trivial usage is to load synchonously:
  #   <%= google_plusone_javascript_include_tag %> #=> <script src="..."></script>
  #
  # To load the script asynchronously, use:
  #   <%= google_plusone_javascript_include_tag(:async => true)
  #
  # By default it takes "en-US" as display language. Add <tt>:lang</tt> option to change,
  # e.g. <tt> :lang => "zh-TW"</tt>
  #
  # To load in explicit mode, add <tt>:explicit => true</tt> option.
  def google_plusone_javascript_include_tag(*args)
    options = {
      :async => false,
      :lang => "en-US",
      :explicit => false
    }.merge(args.extract_options!)

    explicit = options.delete(:explicit)
    options.merge!(:parsetags => "explicit") if explicit

    # explicit parsing can only be applied to synchronized loading
    async = options.delete(:async) && !explicit

    params = options.to_json

    if async
      javascript_tag <<-EOJS
        window.___gcfg = #{options.to_json};
        (function() {
          var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
          po.src = 'https://apis.google.com/js/plusone.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
        })();
      EOJS
    else
      javascript_tag options.to_json, :src => "https://apis.google.com/js/plusone.js"
    end
  end

  # Generates Google+ Social Plugin html structure.
  #
  def google_social_plugin(plugin_name, options, html_options={}) #:nodoc:
    case GooglePlusHelper.settings.social_plugin_version
    when :html5
      html_options.merge! :class => "g-#{plugin_name.to_s}", :data => options
      content_tag "div", "", html_options
    when :xml
      html_options.merge! options
      content_tag "g:#{plugin_name.to_s}", "", html_options
    else
      raise "Unknown Social Plugin Version: #{GooglePlusHelper.settings.social_plugin_version}"
    end
  end

  # Generates the +1 button for specific URL.
  #
  # Arguments:
  #
  # * <tt>url</tt>: the URL to +1.
  # * <tt>options</tt>: (optional) a hash that is identical to the +1 Button attributes listed here[https://developers.google.com/+/plugins/+1button/#plusonetag-parameters].
  #
  # Example - A +1 button in medium size and without annotation:
  #
  #   <%= google_plusone_button("http://example.com", :size => :medium, :annotation => :none)
  def google_plusone_button(url, *args)
    options = args.extract_options!
    options[:href] = url
    html_options = options.delete(:html_options) || {}

    google_social_plugin(:plusone, options, html_options)
  end

  # Generates the "Share on Google+" button for specific URL.
  #
  # Arguments:
  #
  # * <tt>url</tt>: the URL to +1.
  # * <tt>options</tt>: (optional) a hash that is identical to the Share Button attributes listed here[https://developers.google.com/+/plugins/share/#sharetag-parameters].
  #
  # Example - A Share button aligned to right and with vertical-bubble annotation:
  #
  #   <%= google_share_button("http://example.com", :align => :right, :annotation => "vertical-bubble")
  def google_share_button(url, *args)
    options = args.extract_options!
    options.merge! :href => url, :action => :share
    html_options = options.delete(:html_options) || {}

    google_social_plugin(:plus, options, html_options)
  end
end
