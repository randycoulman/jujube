module Jujube
  module Components

    def pollscm(interval)
      {'pollscm' => interval}
    end

    def pollurl(options = {})
      urls = []
      yield(urls) if block_given?
      options.merge!(urls: urls) unless urls.empty?
      to_config("pollurl", options)
    end

    def url(the_url, options = {})
      options = {url: the_url}.merge!(options)
      content = []
      yield(content) if block_given?
      options.merge!(check_content: content) unless content.empty?
      canonicalize_options(options)
    end

    def simple
      {"simple" => true}
    end

    def json(*paths)
      {"json" => paths}
    end

    def xml(*xpaths)
      {"xml" => xpaths}
    end

    def text(*regexes)
      {"text" => regexes}
    end
  end
end
