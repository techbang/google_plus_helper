# GooglePlusHelper

GooglePlusHelper helps you generate Google Plus Social Plugins in your Rails application.  Source code is available [on Github](https://github.com/techbang/google_plus_helper)

## Installation

Add this line to your application's Gemfile:

    gem "google_plus_helper"

or from Github:

    gem "google_plus_helper", :github => "techbang/google_plus_helper"

And then execute:

    $ bundle

## Getting Started: Include the Google Plus JavaScript API

It is easy to include the javascript of Google Plusone:

    <%= google_plusone_javascript_include_tag %>

This will yield a synchronized method (not recommended) of javascript include tag, with default language `en-US`:

    <script src="https://apis.google.com/js/plusone.js" type="text/javascript">
    //<![CDATA[
    {"lang":"en-US"}
    //]]>
    </script>

### Asynchrnoized loading (Recommended)

For best practice, it is recommended to use the **asynchronized method**:

    <%= google_plusone_javascript_include_tag(:async => true) %>

which yields:

    <script type="text/javascript">
    //<![CDATA[
    window.___gcfg = {"lang":"en-US"};
    (function() {
      var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
      po.src = 'https://apis.google.com/js/plusone.js';
      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
    })();
    //]]>
    </script>

### Language

To change then displaying language, specify `:lang` option:

    <%= google_plusone_javascript_include_tag(:async => true, :lang => "zh-TW") %>

### Explicit Loading / Rendering

To load Google Plusone javascript in [explicit mode](https://developers.google.com/+/plugins/+1button/#example-explicit-load), specify `:explicit => true` option:

    <%= google_plusone_javascript_include_tag(:explicit => true) %>

and don't forget to invoke `gapi.plusone.go("container-id")`. See [Google Plusone JavaScript API](https://developers.google.com/+/plugins/+1button/#jsapi) for more details.

## Render Social Plugins

Currently GooglePlusHelper supports **+1 button** and the **share button**.

Notes:

* By default it renders **HTML5 version** of tags.  If you want to use XML version, see Configure GooglePlusHelper below.
* You **have to specify the URL** to +1 or share, even though Google's Social Plugins do not need it explicitly.
* If you want to control what to display on Google+, please specify [Open Graph tags](https://developers.facebook.com/docs/opengraphprotocol/). Currently there is no support to render [Snippet](https://developers.google.com/+/plugins/snippet/).

### The +1 Button

    <%= google_plusone_button("http://example.com") %>

Options are the same that listed in the [+1 Tag Document](https://developers.google.com/+/plugins/+1button/#plusonetag-parameters), except for `href` option, which is overriden by the URL you specified.  For example:

    <%= google_plusone_button("http://example.com", :size => :medium, :annotation => :inline) %>

### Share Button

    <%= google_share_button("http://example.com") %>

Options are the same that listed in the [Share Tag document](https://developers.google.com/+/plugins/share/#sharetag-parameters), except for `href` option, which is overriden by the URL you specified.  For example:

    <%= google_share_button("http://example.com", :align => :right, :annotation => :inline) %>

## Configure GooglePlusHelper

GooglePlusHelper provides some configurable options.  Put them in an initializer if you don't like the defaults:

    GooglePlusHelper.config do |config|
      config.social_plugin_version = :xml # default is :html5
    end

*Hint*: You don't need this initializer if you want to use the default values.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

# License

Copyright (c) 2012 Techbang.com

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.