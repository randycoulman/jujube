# Jujube

[![Gem Version](https://badge.fury.io/rb/jujube.png)](http://badge.fury.io/rb/jujube)
[![Build Status](https://travis-ci.org/randycoulman/jujube.svg?branch=master)](https://travis-ci.org/randycoulman/jujube)
[![Code Climate](https://codeclimate.com/github/randycoulman/jujube.png)](https://codeclimate.com/github/randycoulman/jujube)
![Maintenance Status](https://img.shields.io/badge/maintenance-active-green.svg)

**Jujube** is a Ruby front-end for
[jenkins-job-builder](https://github.com/openstack-infra/jenkins-job-builder).

jenkins-job-builder allows you to specify Jenkins jobs in YAML and then creates or
updates the jobs in a running Jenkins instance.  It provides some tools for removing
duplication from job definitions, but sometimes more abstraction capability is needed.
**Jujube** provides that capability.

Using **Jujube**, you can specify Jenkins jobs using a Ruby DSL (domain-specific language).
**Jujube** then generates the YAML input needed by jenkins-job-builder.  **Jujube** also makes
it easy to define methods that act as job templates or pre-configured components.

## Installation

Add this line to your application's Gemfile:

    gem 'jujube'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jujube

## Usage Instructions

### Running Jujube

To run **Jujube** and convert one or more job definitions to YAML for use by jenkins-job-builder:

```
jujube [--output output-file] file-or-directory*
```

**Jujube** will load all of the specified files (or all of the files in the specified directories)
and generate a single YAML file containing all of the jenkins-job-builder job definitions.

If the `--output` (or `-o` for short) option is provided, the job definitions will be generated into
the specified file.  Any intermediate directories that do not already exist will be created
automatically.

If no output filename is specified, then a file named `jobs.yml` in the current working directory
will be used.

### Defining Jobs

To define a Jenkins job using **Jujube**, use the `job` DSL function.  The most basic job definition
is just a job name:

```ruby
job "my-job"
```

Such a job does absolutely nothing, so you will most likely want to provide a configuration block as
well:

```ruby
job "my-job" do |j|
  # Job configuration goes here...
end
```

In the job configuration block, you can specify attributes for the job and add components to sections.
For example:

```ruby
job "my-job" do |j|
  j.description = "This is my job."  # Specify attributes
  j.quiet_period = 5

  j.axes << slave(:arch, %w{i386 amd64}) # Add components to sections

  j.scm << git(url: "https://example.com/git/my-project", branches: %w{master dev})

  j.triggers << pollscm("@hourly")

  j.wrappers << timeout(type: 'elastic', elastic_percentage: 150, elastic_default_timeout: 5, fail: true)
  j.wrappers << timestamps

  j.builders << shell("bundle && bundle exec rake deploy")

  j.publishers << email_ext(recipients: %w{me@example.com you@example.com})
end
```

The following job attributes are supported:

* `project_type` -- doesn't normally need to be specified.  If any `axes` are added to the
  job, then `project_type` is automatically inferred to be `matrix`
* `description`
* `node`
* `block_upstream`
* `block_downstream`
* `quiet_period`
* `disabled`

The following sections and components are supported:

* `axes`: (`label_expression`, `slave`)
* `parameters`: (`string`, `validating_string`)
* `properties`: (`throttle`)
* `scm`: (`git`, `store`)
* `triggers`: (`pollscm`, `pollurl`, `reverse`)
* `wrappers`: (`timeout`, `timestamps`)
* `builders`: (`shell`)
* `publishers`: (`archive`, `cppcheck`, `email_ext`, `fitnesse`, `ircbot`, `junit`, 
  `trigger`, `unittest`, `xunit`)
* `notifications`: None defined yet

See [the end-to-end example job](examples/fixtures/endToEnd/endToEnd.job) for example
uses of all of the supported attributes, sections, and components.

In general, component options are typically specified as standard Ruby hashes.  The option
names are the same as in the
[jenkins-job-builder documentation](http://docs.openstack.org/infra/jenkins-job-builder/),
except that you need to use underscores (`_`) instead of dashes (`-`) in the option names.

### Helper Methods

In your own projects, you can define helper methods that pre-configure jobs or components.
Simply `require` the Ruby files containing your helper methods into your job files and use
them just like the **Jujube** supplied methods.  For example:

```ruby
def template_job(name, description)
  job name do |j|
    j.description = description
    j.quiet_period = 5
    j.scm << standard_git(name)
    j.triggers << pollscm("@hourly")
    j.wrappers << timestamps

    yield j if block_given?
  end
end

def standard_git(repo_name)
  git(url: "https://example.com/git/#{repo_name}", branches: %w{master dev})
end

template_job "my-job", "This is my job" do |j|
  j.builders << shell("rake deploy")
end
```

### Things to Note

* **Jujube** doesn't do any input validation.  Rather than duplicating the validation that
  jenkins-job-builder already does, **Jujube** accepts any component options provided in a job
  definition and passes them through to the YAML file.  This actually makes **Jujube** quite
  flexible and able to automatically support new options that are added in jenkins-job-builder.

* **Jujube** does not yet support all of the components that jenkins-job-builder supports.  New
  components are easy to add, and pull requests are more than welcome.

## Extending Jujube

The `Job` class is the main class in **Jujube**.  It should be essentially complete now.  The
main work left to be done is to define the remaining components supported by jenkins-job-builder.
Components are defined in the various files in the `components` sub-directory.  There is one file
per component type.

Most components can be defined using the `standard_component` "macro".  If the component simply
takes a hash of options, then it is a standard component.  Otherwise, a specialized method must
be written for the component.  There are a few examples of these in the codebase.

If you'd like to add a component that requires some odd configuration and you're not sure how to
tackle it, contact me and I'll be happy to help.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Make your change.  Please follow the coding conventions of the project and write good unit tests.
   If you are adding a new component, please update `acceptance/fixtures/endToEnd/endToEnd.job` and
   `acceptance/fixtures/endToEnd/expected.yml` as well.
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

## Acknowledgements

Thanks to Jason Roelofs, Chris Gaffney, and Sarah Mei for their input and feedback as I worked
on this project.
