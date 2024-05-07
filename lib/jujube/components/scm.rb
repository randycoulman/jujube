module Jujube
  module Components

    # Helper methods for creating SCM components.
    module Scm
      extend Macros

      # @!method git(options = {})
      # Specify a `git` SCM for a job.
      #
      # See {https://jenkins-job-builder.readthedocs.io/en/latest/publishers.html#scm.git}.
      #
      # @param options [Hash] The configuration options for the component.
      # @return [Hash] The specification for the component.
      standard_component :git

      # Specify a `store` SCM for a job.
      #
      # See {https://jenkins-job-builder.readthedocs.io/en/latest/scm.html#scm.store}.
      #
      # `store` can watch multiple pundles (packages or bundles) The specification for each
      # pundle is added in a nested configuration block using the {#package} or {#bundle} method.
      #
      # @example
      #    job "store-example" do |j|
      #      j.scm << store(script: "SCRIPT", repository: "REPO") do |pundles|
      #        pundles << package("PACKAGE")
      #        pundles << bundle("BUNDLE")
      #      end
      #    end
      #
      # @param options [Hash] Top-level options for configuring the component.
      # @yieldparam pundles [Array] An array to which nested pundle specifications should be
      #   added by the block.
      # @return [Hash] The specification for the component.
      def store(options = {}, &block)
        to_config("store", nested_options(:pundles, options, &block))
      end

      # @!group store Pundle Specifications

      # Specify a `package` to check for a {#store} SCM.
      #
      # @param name [String] The name of the package to check.
      # @return [Hash] The specification for the package.
      def package(name)
        {"package" => name}
      end

      # Specify a `bundle` to check for a {#store} SCM.
      #
      # @param name [String] The name of the bundle to check.
      # @return [Hash] The specification for the package.
      def bundle(name)
        {"bundle" => name}
      end

      # @!endgroup

    end
  end
end
