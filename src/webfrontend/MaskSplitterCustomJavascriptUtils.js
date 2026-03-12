// This has to be a Javascript file, because function is a reserved word in the coffee script compiler.
// I need to get the AsyncFunction constructor like this because, unlike Function, AsyncFunction is not global.
var MaskSplitterCustomJavascriptUtils;

MaskSplitterCustomJavascriptUtils = (function () {
  function MaskSplitterCustomJavascriptUtils() { }

  MaskSplitterCustomJavascriptUtils.getAsyncFunctionConstructor = function () {
    return (async function () { }).constructor;
  };

  return MaskSplitterCustomJavascriptUtils;

})();