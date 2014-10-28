module Jujube
  module Components

    # Helper methods for creating trigger components.
    module Triggers

      # Specify a `reverse` trigger for a job.
      #
      # See {http://ci.openstack.org/jenkins-job-builder/triggers.html#triggers.reverse}.
      #
      # @param opts [Hash] The reverse project trigger options
      # @option opts [String] :watch_projects A String or Array of Strings of project names
      # @option opts [String] :trigger_on The condition to be met. One of 'success', 'unstable' or 'failure'
      # @return [Hash] The specification for the component.
      def reverse(opts)
        { 'reverse' => { 'jobs' => Array(opts[:watch_projects]).join(','), 'result' => opts[:trigger_on] } }
      end

      # Specify a `pollscm` trigger for a job.
      #
      # See {http://ci.openstack.org/jenkins-job-builder/triggers.html#triggers.pollscm}.
      #
      # @param interval [String] The polling interval, using `cron` syntax.
      # @return [Hash] The specification for the component.
      def pollscm(interval)
        {'pollscm' => interval}
      end

      # Specify a `pollurl` trigger for a job.
      #
      # This trigger requires support in jenkins-job-builder that has not yet been merged.
      # See {https://review.openstack.org/83524/} for the patch.
      #
      # `pollurl` can poll several URLs.  Each URL specification is added
      # in a nested configuration block using the {#url} method.
      #
      # @example
      #   job "pollurl-example" do |j|
      #     j.triggers << pollurl(cron: "CRON") do |urls|
      #       urls << url("URL", check_date: true) do |content|
      #         content << json("JSON_PATH1", "JSON_PATH2")
      #       end
      #     end
      #   end
      #
      # @param options [Hash] Top-level options for configuring the component.
      # @yieldparam urls [Array] An array to which nested URL specifications should be
      #   added by the block.
      # @return [Hash] The specification for the component.
      def pollurl(options = {}, &block)
        to_config("pollurl", nested_options(:urls, options, &block))
      end

      # @!group pollurl Helpers

      # Configure a URL to poll in a {#pollurl} component.
      #
      # If you want to check for changes to the actual content returned from the URL,
      # (the `check-content` setting), pass a block that configures the content-type
      # specifications using one or more of {#simple}, {#json}, {#xml}, or {#text}.
      #
      # @param the_url [String] The URL to monitor.
      # @param options [Hash] Top-level options for this URL.
      # @yieldparam content_types [Array] An array to which nested content-type
      #   specifications should be added by the block.
      # @return [Hash] The specification for the URL.
      def url(the_url, options = {}, &block)
        options = {url: the_url}.merge!(options)
        canonicalize_options(nested_options(:check_content, options, &block))
      end

      # @!endgroup

      # @!group pollurl Content Types

      # Configure a simple content check inside a {#url} specification of a
      # {#pollurl} trigger.
      # @return [Hash] The specification for the content type.
      def simple
        {"simple" => true}
      end

      # Configure a JSON content check inside a {#url} specification of a
      # {#pollurl} trigger.
      #
      # @param paths [String...] Zero or more JSONPath expressions.  Only changes to
      #   the parts of the JSON response that match one of the `paths` will trigger a build.
      # @return [Hash] The specification for the content type.
      def json(*paths)
        {"json" => paths}
      end

      # Configure an XML content check inside a {#url} specification of a
      # {#pollurl} trigger.
      #
      # @param xpaths [String...] Zero or more XPath expressions.  Only changes to
      #   the parts of the XML response that match one of the `xpaths` will trigger a build.
      # @return [Hash] The specification for the content type.
      def xml(*xpaths)
        {"xml" => xpaths}
      end

      # Configure a text content check inside a {#url} specification of a
      # {#pollurl} trigger.
      #
      # @param regexes [String...] Zero or more regular expressions.  Only changes to
      #   the parts of the text response that match one of the `regexes` will trigger a build.
      # @return [Hash] The specification for the content type.
      def text(*regexes)
        {"text" => regexes}
      end

      # @!endgroup

    end
  end
end
