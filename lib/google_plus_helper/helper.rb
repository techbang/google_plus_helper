# https://developers.google.com/+/
# Currently there is no support for generating Schema.org meta tags.
# Please use Open Graph tags.
module GooglePlusHelper
  # load google plusone javascript
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

  def google_social_plugin(plugin_name, options, html_options={})
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

  # google_plusone_button generates plusone button for specific URL
  #
  # default arguments: (implicitly assigned according to +1 button document)
  #   size: standard
  #   annotation: bubble
  def google_plusone_button(url, *args)
    options = args.extract_options!
    options[:href] = url
    html_options = options.delete(:html_options) || {}

    google_social_plugin(:plusone, options, html_options)
  end

  def google_share_button(url, *args)
    options = args.extract_options!
    options.merge! :href => url, :action => :share
    html_options = options.delete(:html_options) || {}

    google_social_plugin(:plus, options, html_options)
  end
end
