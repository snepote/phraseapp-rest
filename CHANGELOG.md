# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.4.2] - 2019-11-20
### Fixed
- Fixed /projects when paginated

## [0.4.1] - 2019-04-29
### Fixed
- Fixed warning in Ruby 2.4+ (deprecated toplevel constants TRUE, FALSE and NIL)

## [0.4.0] - 2018-12-02
### Added
- List adds filter by name

## [0.3.0] - 2018-12-01
### Added
- Translations supports now pagination
- Locale download

### Changed
- IMPORTANT: removed the json cast to OpenStruct due to a [bug in Oj](https://github.com/ohler55/oj/issues/239) which ignores the ```object_class``` parameter and create conflicts specially on some Rails applications. Now always returns a Hash

## [0.2.0] - 2018-11-20
### Added
- Gem configuration block

### Changed
- 404 responses returns empty body "[]"

## [0.1.0] - 2018-11-11
### First version
