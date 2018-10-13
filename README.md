SiReGen
=======

> A CRUD resource generator for Sinatra. Currently supports the creation of generic CRUD controllers for a given model name.


## Installation

This repo contains two files: `siregen.rb` and `raketask`. You also need to have the gem [`dry-inflector`][inflector] installed.

  * To run the runner file, pass in the model name as ARGV. The runner file will generate the controller file with the proper name. It will be up to you to place it in the right directory.

      ```bash
      ruby siregen.rb user
      ```

  * To use the raketask, copy and paste its text into your Rakefile. The raketask assumes you have a directory called app/controllers. You may want to namespace the task with any other generation tasks you have:

      ```bash
      rake generate:controller NAME=user
      ```

  * The task will also work in isolation:

      ```bash
      rake controller NAME=user
      ```

ENJOY!


  [inflector]:  https://github.com/dry-rb/dry-inflector
