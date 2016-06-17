# Promise FS
Implements module FS using Promises

## Installation
You can install this module using NPM:

```
$ npm i --save promise-fs
```

## Usage

```coffee
  fs = require 'promise-fs'

  fs.readFile 'path/to/file'
    .then (content) -> console.log content # Doing something with content
    .catch (err) -> console.log err # Catching error
```
