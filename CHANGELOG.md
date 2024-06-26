# Change Log

All notable changes to this gem will be documented here. This project
adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased][unreleased]

## [0.16.0][0.16.0]

### Added

- Support the `gtest` test result type in the `xunit` publisher (see
  https://jenkins-job-builder.readthedocs.io/en/latest/publishers.html#publishers.xunit)  ([#20](https://github.com/randycoulman/jujube/pull/20)) (with @robin-verhoeven)

## [0.15.0][0.15.0]

### Added

- Support the `gitlab` trigger (see https://jenkins-job-builder.readthedocs.io/en/latest/triggers.html#triggers.gitlab) ([#18](https://github.com/randycoulman/jujube/pull/18)) (with @halverneus)

- Support the `gitlab-notifier` publisher (see https://jenkins-job-builder.readthedocs.io/en/latest/publishers.html#publishers.gitlab-notifier) ([#19](https://github.com/randycoulman/jujube/pull/19)) (with @halverneus)

## [0.14.0][0.14.0]

### Added

- Support the `concurrent` job attribute
  (see https://jenkins-job-builder.readthedocs.io/en/latest/definition.html?highlight=concurrent) ([#13](https://github.com/randycoulman/jujube/pull/11)) (@mroelandts)

## [0.13.0][0.13.0]

### Added

- Support the `copyartifact` builder (see https://jenkins-job-builder.readthedocs.io/en/latest/builders.html#builders.copyartifact) ([#11](https://github.com/randycoulman/jujube/pull/11)) (@ktreis)

## [0.12.0][0.12.0]

### Added

- Support the `string` parameter (see https://jenkins-job-builder.readthedocs.io/en/latest/parameters.html#parameters.string) ([#3](https://github.com/randycoulman/jujube/pull/3)) (@jgeysens)
- Support Rake 11.x versions ([#4](https://github.com/randycoulman/jujube/pull/4))
- Support the `validating_string` parameter (see https://jenkins-job-builder.readthedocs.io/en/latest/parameters.html#parameters.validating-string) ([#7](https://github.com/randycoulman/jujube/pull/7))
- Support the `trigger_parameterized_builds` publisher (see https://jenkins-job-builder.readthedocs.io/en/latest/publishers.html#publishers.trigger-parameterized-builds) ([#9](https://github.com/randycoulman/jujube/pull/9))

## [0.11.0][0.11.0]

### Breaking Changes

- The `pollscm` component has been updated to conform to the new API in jenkins-job-builder 1.3.0 and later. See https://jenkins-job-builder.readthedocs.io/en/latest/triggers.html#triggers.pollscm for details of the change. If you need to use the `pollscm` component and older versions of jenkins-job-builder, then stick with version 0.10.0 or earlier of Jujube.

- With this release, we are no longer officially supporting Ruby versions less than 2.1. Previous versions of Ruby are [considered end-of-life (EOL)](https://www.ruby-lang.org/en/downloads/) by the Ruby core team.

### Added

- Link to the documentation for the `pollurl` trigger that has new been merged into jenkins-job-builder.

### Changed

- The jenkins-job-builder documentation has moved to a new location, so all documentation links (including within this CHANGELOG) have been updated.

## [0.10.0][0.10.0]

### Added

- Support the `priority_sorter` property (see https://jenkins-job-builder.readthedocs.io/en/latest/properties.html#properties.priority-sorter).
- Links to documentation for the `fitnesse` publisher and `store` SCM that have now been merged into jenkins-job-builder.
- This CHANGELOG.

## [0.9.0][0.9.0] - 2015-04-09

### Added

- Support the `disabled` job attribute
  (see https://jenkins-job-builder.readthedocs.io/en/latest/general.html).

## [0.8.0][0.8.0] - 2014-10-29

- Support the `throttle` job property (see https://jenkins-job-builder.readthedocs.io/en/latest/properties.html#properties.throttle).

## [0.7.0][0.7.0] - 2014-10-28

### Added

- Support the `reverse` trigger (see https://jenkins-job-builder.readthedocs.io/en/latest/triggers.html#triggers.reverse).

## [0.6.0][0.6.0] - 2014-08-25

### Added

- The `jujube` command now understands the `--version` argument and reports the gem version.

## [0.5.2][0.5.2] - 2014-04-15

### Added

- Support the `fitnesse` publisher (see https://jenkins-job-builder.readthedocs.io/en/latest/publishers.html#publishers.fitnesse).

## [0.5.1][0.5.1] - 2014-04-07

### Added

- Support the `store` SCM (see https://jenkins-job-builder.readthedocs.io/en/latest/scm.html#scm.store).

## [0.5.0][0.5.0] - 2014-03-28

### Added

- Initial public release.

[unreleased]: https://github.com/randycoulman/jujube/compare/v0.16.0...HEAD
[0.15.0]: https://github.com/randycoulman/jujube/compare/v0.15.0...v0.16.0
[0.15.0]: https://github.com/randycoulman/jujube/compare/v0.14.0...v0.15.0
[0.14.0]: https://github.com/randycoulman/jujube/compare/v0.13.0...v0.14.0
[0.13.0]: https://github.com/randycoulman/jujube/compare/v0.12.0...v0.13.0
[0.12.0]: https://github.com/randycoulman/jujube/compare/v0.11.0...v0.12.0
[0.11.0]: https://github.com/randycoulman/jujube/compare/v0.10.0...v0.11.0
[0.10.0]: https://github.com/randycoulman/jujube/compare/v0.9.0...v0.10.0
[0.9.0]: https://github.com/randycoulman/jujube/compare/v0.8.0...v0.9.0
[0.8.0]: https://github.com/randycoulman/jujube/compare/v0.7.0...v0.8.0
[0.7.0]: https://github.com/randycoulman/jujube/compare/v0.6.0...v0.7.0
[0.6.0]: https://github.com/randycoulman/jujube/compare/v0.5.2...v0.6.0
[0.5.2]: https://github.com/randycoulman/jujube/compare/v0.5.1...v0.5.2
[0.5.1]: https://github.com/randycoulman/jujube/compare/v0.5.0...v0.5.1
[0.5.0]: https://github.com/randycoulman/jujube/compare/master@%7B2014-03-11%7D...v0.5.0
