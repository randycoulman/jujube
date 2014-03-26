module Jujube
  module Components

    def pollscm(interval)
      {'pollscm' => interval}
    end

    def pollurl(options = {}, &block)
      to_config("pollurl", nested_options(:urls, options, &block))
    end

    def url(the_url, options = {}, &block)
      options = {url: the_url}.merge!(options)
      canonicalize_options(nested_options(:check_content, options, &block))
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
