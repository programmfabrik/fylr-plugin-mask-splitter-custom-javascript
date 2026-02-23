class MaskSplitterCustomJavascript extends CustomMaskSplitter


    isSimpleSplit: ->
        false
    
    getOptions: ->
        [
            form:
                label: "Javascript Name"
            type: CUI.Input
            name: "javascript_name"
        ]

    renderField: (opts) ->
        data = opts.data
        baseConfig = ez5.session.getBaseConfig("plugin", "fylr-plugin-mask-splitter-custom-javascript")
        javascriptName = @getDataOptions().javascript_name
        console.log "MaskSplitterCustomJavascript.renderField opts: ", opts
        console.log "MaskSplitterCustomJavascript.base config: ", baseConfig
        console.log "MaskSplitterCustomJavascript.javascript_name: ", javascriptName

        if !javascriptName
            return new CUI.Label("MaskSplitterCustomJavascript: " + $$("mask.splitter.custom.javascript.message.javascript_name_missing"))
        if !Array.isArray(baseConfig.custom_javascript.value) || baseConfig?.custom_javascript?.value.length < 1
            return new CUI.Label("MaskSplitterCustomJavascript: " + $$("mask.splitter.custom.javascript.message.base_config_missing"))

        baseConfigCustomJavascript = baseConfig.custom_javascript.value.find((value) => value.javascript_name == javascriptName) 
        if !baseConfigCustomJavascript?.javascript_code 
            return new CUI.Label("MaskSplitterCustomJavascript: " + $$("mask.splitter.custom.javascript.message.no_code_found_for_name"))


        try
            customFunction = new Function('opts', baseConfigCustomJavascript.javascript_code)
            try
                resultValue = customFunction(opts)

                if resultValue instanceof CUI.Element
                    return resultValue
                else    
                    return new CUI.Label(text: "MaskSplitterCustomJavascript: " + $$("mask.splitter.custom.javascript.message.wrong_function_return_value"))


            catch error
                console.error "MaskSplitterCustomJavascript: Error executing custom Javascript:", error.message
        catch error
            console.error "MaskSplitterCustomJavascript: Error when creating Javascript-Function:", error.message        

MaskSplitter.plugins.registerPlugin(MaskSplitterCustomJavascript)