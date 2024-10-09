# My-corporate-bash

[![release-version](https://img.shields.io/badge/Version-1.0.0-blue)]()
[![license](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://github.com/MaloLM/my-corporate-bash/blob/main/LICENSE)
[![language](https://img.shields.io/badge/Language-shell-blue)](https://en.wikipedia.org/wiki/Scripting_language)

Display an ASCII format image at the start of your bash session.

<demo>

![software demonstration: an opened terminal is used to setup a company logo, then show the result, the user validates the result whoch is now configure at the start of any bash session.](./assets/demo.gif)

## Install

Go to the repository root

```shell
sudo bash install
```

#### Requirements

First, you will need to install following dependancy: [ascii-image-converter](https://github.com/TheZoraiz/ascii-image-converter)

## Setup example

```shell
mycorporatebash setup ./images.my_image.png -P 0.5 -C
```

#### Approximate proportion width image filling

```
[ terminal width ]
[-.........] -P 0.1
[--........] -P 0.2
[---.......] -P 0.3
[----......] -P 0.4
[-----.....] -P 0.5
[------....] -P 0.6
[-------...] -P 0.7
[--------..] -P 0.8
[---------.] -P 0.9
[----------] -P 1

--- image filling
... void filling
```

### Options

| Option     | Description                                                                                                             |
| ---------- | ----------------------------------------------------------------------------------------------------------------------- |
| -P _value_ | Sets the proportion of the terminal width used for displaying the image. The value must be between 0 (0%) and 1 (100%). |
| -C         | Retains the original colors of the source image. If not used, the image will be displayed in white.                     |
| -h, --help | Displays a help message.                                                                                                |

## Environments

| Tested | OS     | Version       | Architecture |
| ------ | ------ | ------------- | ------------ |
| ✅     | macOS  | 15.0 (24A335) | aarch64      |
| ❌     | Ubuntu | 20.04 LTS     | x86_64       |
| ❌     | WSL    | Ubuntu 20.04  | x86_64       |

## Troubleshooting

- Using -C but nothing shows : check your terminal client supports 24bits or 8bits colors
