# The YaST C++ Testing Image

[![Build Status](https://travis-ci.org/yast/docker-yast-cpp.svg?branch=master)](https://travis-ci.org/yast/docker-yast-cpp)

This repository builds a [Docker](https://www.docker.com/) image which is used
for running the CI tests at [Travis](https://travis-ci.org/).
The built image is available at the [yastdevel/cpp](
https://hub.docker.com/r/yastdevel/cpp/) Docker repository.

## Automatic Rebuilds

- The image is rebuilt whenever a commit it pushed to the `master` branch.
  This is implemented via GitHub webhooks.

- Additionally the image is periodically rebuilt to ensure the latest YaST
  packages from the [YaST:Head](https://build.opensuse.org/project/show/YaST:Head)
  OBS project are used even when the image configuration has not been changed.
  The build is triggered by the [docker-trigger-yastdevel-cpp](
  https://ci.opensuse.org/view/Yast/job/docker-trigger-yastdevel-cpp/)
  Jenkins job.

- The upstream dependency to the [opensuse](https://hub.docker.com/_/opensuse/)
  project is defined so whenever the base openSUSE system is updated the image
  should be automatically rebuilt as well.

## Triggering a Rebuild Manually

If for some reason the automatic rebuilds do not work or you need to fix
a broken build you can trigger rebuild manually.

- Go to the [Build Settings](
https://hub.docker.com/r/yastdevel/cpp/~/settings/automated-builds/) tab
and press the *Trigger* button next to the *master* branch configuration line.

- If you need to trigger the build from a script check the *Build Triggers*
section at the bottom, press the *Show examples* link to display the `curl`
commands. (The commands contain a secret access token, keep it in a safe place,
do not put it in a publicly visible place.)

## The Image Content

This image is based on the latest openSUSE Tumbleweed image, additionally
it contains the packages needed for running tests for YaST packages written
in cpp.

## Using the image

The image contains an `yast-travis` script which runs all the checks and tests.

The workflow is:

- Copy the sources into the `/tmp/sources` directory.
- If the code needs additional packages install them using the `zypper install`
  command from the local `Dockerfile`. (If the package is need by more modules
  you can add it into the original Docker image.)
- Run the `yast-travis` script.

