# FIDATA Build Environment

Checks that environment is sane and meets requirements to build FIDATA.

## Usage:

### Check local environment:

Prerequisites:
*	Standalone Ruby with Bundler (recommended)

or

*	[Chef DK](https://downloads.chef.io/chefdk)

```
git clone https://github.com/FIDATA/build-environment
cd build-environment
```

If you have Ruby & Bundler:
```
bundle install
bundle exec inspec exec .
```
If you have Chef DK:
```
chef exec inspec exec .
```

## Sources of prerequisites
*	http://www.postgresql.org/docs/9.3/static/install-requirements.html
*	http://www.postgresql.org/docs/9.3/static/install-windows-full.html#AEN26181
*	http://qt-project.org/wiki/Building-Qt-5-from-Git
*	http://qt-project.org/doc/qt-5/windows-requirements.html


## Development
*	Before commit run checks:
```
inspec check .
```


------------------------------------------------------------------------
Copyright © 2014-2017  Basil Peace

This file is part of FIDATA Build Environment.

Copying and distribution of this file, with or without modification,
are permitted in any medium without royalty provided the copyright
notice and this notice are preserved.  This file is offered as-is,
without any warranty.
