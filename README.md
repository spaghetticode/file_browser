# FileBrowser

This is a rails 3 engine that allows your to browse the filesystem via a modal window on the browser, simulating the operative system file open window. It relies on twitter bootstrap modal javascript.

![modal example](https://raw.github.com/spaghetticode/file_browser/master/docs/modal.jpg "modal example")

## Demo

You can view a demo of the modal window by starting the rails app in ```spec/dummy```.


## Usage

Add the gem to your rails app Gemfile:

```ruby
gem 'file_browser'
```

Add the gem asset manifests:
in your rails app application.js add:
```
//= require file_browser/application
```
same goes in your rails app application.css:
```
*= require file_browser/application
```

Include the modal html in any view of your application:
```ruby
<%= render 'file_browser/modal' %>
```

To start the modal window use the following javascript code:
```js
FileBrowser.Modal.init($('#file-browser'));
```

# TODO

* Integration testing
* Add configuration for start path
* Check workings on windows
