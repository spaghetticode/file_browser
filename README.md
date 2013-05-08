# Filesystem Browser

This is a rails 3 engine that allows your to browse the filesystem via a modal window on the browser, simulating the operative system file open window. It relies on twitter bootstrap modal javascript.

![modal example](https://raw.github.com/spaghetticode/fs_browser/master/docs/modal.jpg "modal example")

## Demo

You can view a demo of the modal window by starting the rails app in ```spec/dummy```.


## Usage

Add the gem to your rails app Gemfile:
```ruby
gem 'fs_browser'
```
and run the bundle command:
```bash
bundle
```


Add the gem asset manifests:
in your rails app application.js add:
```
//= require fs_browser/application
```
same goes in your rails app application.css:
```
*= require fs_browser/application
```

Include the modal html in any view of your application:
```ruby
<%= render 'fs_browser/modal' %>
```

To start the modal window use the following javascript code:
```js
FsBrowser.Modal.init();
```


## Event Callbacks

There are a few builtin callbacks available when interacting with the modal window:

* single click on a filesystem entry triggers ```FsBrowser.Callbacks.entryClick(event, entry)```
* double click on a filesystem entry triggers ```FsBrowser.Callbacks.entryDblClick(event, entry)```
* click on the submit button triggers ```FsBrowser.Callbacks.modalSubmit(event)```

There are simple defaults for these callbacks that just log in the browser console.
Customize them by overriding methods in ```app/assets/fs_browser/callbacks.js.coffee```


## Configuration

The default starting path for the modal window is the root path of the filesystem ("/").
You can customise the behaviour adding an initializer in your app ```config``` directory with
the following code:
```ruby
FsBrowser::Path.base = '/some/other/path'
```


# TODO

* Check workings on windows
