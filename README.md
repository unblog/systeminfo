# systeminfo

Collects system information and operating status while the output is written to an HTML file.

[![Travis](https://img.shields.io/travis/rust-lang/rust.svg)](https://github.com/unblog/systeminfo)
[![GitHub issues](https://img.shields.io/github/issues/donkey/systeminfo.svg)](https://github.com/unblog/systeminfo/issues)
[![GitHub forks](https://img.shields.io/github/forks/donkey/systeminfo.svg)](https://github.com/unblog/systeminfo/network)
[![GitHub stars](https://img.shields.io/github/stars/donkey/systeminfo.svg)](https://github.com/unblog/systeminfo/stargazers)
[![Github All Releases](https://img.shields.io/github/downloads/atom/atom/total.svg)](https://github.com/unblog/systeminfo)
[![Scrutinizer](https://img.shields.io/scrutinizer/g/filp/whoops.svg)](https://github.com/unblog/systeminfo)
[![AUR](https://img.shields.io/aur/license/yaourt.svg)](https://github.com/unblog/systeminfo)

## Preface

The purpose is to systematize the helpdesk department, callecting stats of linux machines with accurat health data, build reporting and analysis to provide problem solving, it allows a efficient and fatser settlement.

Helpful in remote maintenance, after running sysinfo the report can be sent to the helpdesk.

## Usage

This bash script is executable on several Linux distributions, suitable and tested for Ubuntu, Debian, CentOS and Fedora.

Open a Linux Terminal (Ctrl+Alt+T) and execute sysinfo.sh, root is not mandatory, but more data will be collected.

```sh
$ git clone https://github.com/unblog/systeminfo.git
$ cd systeminfo
$ chmod +x sysinfo.sh
$ ./sysinfo.sh
```

Preferred to use sysinfo for a helpdesk department, place the shell script on the webserver and save it as sysinfo.txt under the document root.

Execute sysinfo using curl out from bash:

```sh
~]# . <(curl -s https://ipline.ch/echo/sysinfo.txt)
```

## Feedback

If you have problems, questions, ideas or suggestions, please contact my by posting to a suitable [mail](http://think.unblog.ch/stay-in-touch).

## Git
```
git clone https://github.com/unblog/systeminfo.git
```

## Screenshot
![System Information](https://github.com/unblog/systeminfo/blob/master/sysinfo.png)

## Addendum

This script is intentional developed in not very structured way, so it is simply to modify individual lines or omit them altogether, it should be easily customizable.

## license

donkey/systeminfo is licensed under the MIT License.
