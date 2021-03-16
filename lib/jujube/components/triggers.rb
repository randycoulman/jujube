module Jujube
  module Components

    # Helper methods for creating trigger components.
    module Triggers
      extend Macros

      # @!method gitlab(options = {})
      # Specify a `gitlab` trigger for a job.
      #
      # See {https://docs.openstack.org/infra/jenkins-job-builder/triggers.html#triggers.gitlab}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :gitlab

      # @!method pollscm(options = {})
      # Specify a `pollscm` trigger for a job.
      #
      # This trigger requires jenkins-job-builder 1.3.0 or later.
      #
      # See {http://docs.openstack.org/infra/jenkins-job-builder/triggers.html#triggers.pollscm}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :pollscm

      # Specify a `pollurl` trigger for a job.
      #
      # See {http://docs.openstack.org/infra/jenkins-job-builder/triggers.html#triggers.pollurl}.
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

      # Specify a `reverse` trigger for a job.
      #
      # See {http://docs.openstack.org/infra/jenkins-job-builder/triggers.html#triggers.reverse}.
      #
      # @param options [Hash] The reverse project trigger options.
      # @option options [String, Array<String>] :jobs The jobs to watch. Note that
      #   jenkins-job-builder takes a string of comma-separated job names; Jujube does that
      #   formatting automatically, so pass in a String or Array of Strings.
      # @option options [String] :result Build results to monitor for.
      #   One of 'success', 'unstable' or 'failure'.
      # @return [Hash] The specification for the component.
      def reverse(options = {})
        formatted_jobs = Array(options[:jobs]).join(", ")
        to_config("reverse", options.merge(jobs: formatted_jobs))
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
