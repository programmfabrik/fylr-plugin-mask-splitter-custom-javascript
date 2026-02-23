> This Plugin / Repo is being maintained by a community of developers.
There is no warranty given or bug fixing guarantee; especially not by
Programmfabrik GmbH. Feel free to directly contact the committing
developers.

# fylr-plugin-mask-splitter-custom-javascript

This is a plugin for [fylr](https://documentation.fylr.cloud/docs). Add a mask splitter and write custom javascript to make the splitter do whatever you need it to do.

## installation

The latest version of this plugin can be found [here](https://github.com/programmfabrik/fylr-plugin-mask-splitter-custom-javascript/releases/latest/download/MaskSplitterCustomJavascript.zip).

The ZIP can be downloaded and installed using the plugin manager, or used directly (recommended).

Github has an overview page to get a list of [all release](https://github.com/programmfabrik/fylr-plugin-mask-splitter-custom-javascript/releases/).

## usage
The base-config has a repeatable block of 4 fields and the mask splitter created by this plugin has 1 field to configure which javascript to use.

#### base-config
- __Name__: The name that will be used to identify the javascript
- __Javascript-Function__: The function that will be executed by the mask splitter. The function will get the same parameters as the renderField-function in the mask splitter. You only need to write the content of the function, not the definition. The function must return an instance of CUI.Element
```
function (opts) {
    // only write what is between the function parenthesis
}
```
- __Show in editor__: Flag you can use in your function to control visibility of the splitter when in editor view
- __Show in detail view__: Flag you can use in your function to control visibility of the splitter when in detail view

#### mask splitter config
- __Javascript Name__: Name used to identify which of the base config scripts should be used

## sources

The source code of this plugin is managed in a git repository at <https://github.com/programmfabrik/fylr-plugin-mask-splitter-custom-javascript>.
