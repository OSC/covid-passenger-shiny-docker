# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.0]

* Move to building R from the source instead of using the OS package because of liblas
  throws invalid instruction errors that core dump in [4](https://github.com/OSC/covid-passenger-shiny-docker/pull/4)
* Force the use of cairo because the default Xlib doesn't work to generate PNGs.
  [5](https://github.com/OSC/covid-passenger-shiny-docker/pull/5)

## [0.2.0]

* add spdep R package
* fix container caching during build

## 0.1.0

* Initial Release

[Unreleased]:https://github.com/OSC/covid-passenger-shiny-docker/compare/v0.3.0..HEAD
[0.3.0]: https://github.com/OSC/covid-passenger-shiny-docker/compare/v0.2.0..v0.3.0
[0.2.0]: https://github.com/OSC/covid-passenger-shiny-docker/compare/v0.1.0..v0.2.0
