# frozen_string_literal: true

module Onebox
  module Engine
    class VideoOnebox
      include Engine

      matches_regexp(/^(https?:)?\/\/.*\.(mov|mp4|webm|ogv)(\?.*)?$/i)

      def always_https?
        WhitelistedGenericOnebox.host_matches(uri, WhitelistedGenericOnebox.https_hosts)
      end

      def to_html
        # Fix Dropbox image links
        if @url[/^https:\/\/www.dropbox.com\/s\//]
          @url.sub!("https://www.dropbox.com", "https://dl.dropboxusercontent.com")
        end

        escaped_url = ::Onebox::Helpers.normalize_url_for_output(@url)
        <<-HTML
          <div class="onebox video-onebox">
            <video width='100%' height='100%' controls>
              <source src='#{escaped_url}'>
              <a href='#{escaped_url}'>#{@url}</a>
            </video>
          </div>
        HTML
      end

      def placeholder_html
        ::Onebox::Helpers.video_placeholder_html
      end
    end
  end
end
