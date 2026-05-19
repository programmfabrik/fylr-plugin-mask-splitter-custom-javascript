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

        if(opts.mode != 'detail' && opts.mode != 'editor') 
            return;
        uuid = crypto.randomUUID()
        data = opts.data
        baseConfig = ez5.session.getBaseConfig("plugin", "mask-splitter-custom-javascript")
        javascriptName = @getDataOptions().javascript_name
        console.log "MaskSplitterCustomJavascript.renderField opts: ", opts
        console.log "MaskSplitterCustomJavascript.base config: ", baseConfig
        console.log "MaskSplitterCustomJavascript.javascript_name: ", javascriptName



        if !javascriptName
            return new CUI.Label(
                text: "MaskSplitterCustomJavascript: " + $$("mask.splitter.custom.javascript.message.javascript_name_missing")
            )
        if !Array.isArray(baseConfig.custom_javascript.value) || baseConfig?.custom_javascript?.value.length < 1
            return new CUI.Label(
                text: "MaskSplitterCustomJavascript: " + $$("mask.splitter.custom.javascript.message.base_config_missing")
            )

        baseConfigCustomJavascript = baseConfig.custom_javascript.value.find((value) => value.javascript_name == javascriptName) 
        if !baseConfigCustomJavascript?.javascript_code 
            return new CUI.Label(
                text: "MaskSplitterCustomJavascript: " + $$("mask.splitter.custom.javascript.message.no_code_found_for_name")
            )

        if(opts.mode == 'detail' && !baseConfigCustomJavascript?.show_in_detail) 
            return;
        if(opts.mode == 'editor' && !baseConfigCustomJavascript?.show_in_editor) 
            return;


        div = CUI.dom.div()

        div.setAttribute('id', 'mask-splitter-custom-javascript-' + uuid)

        try
            AsyncFunction = MaskSplitterCustomJavascriptUtils.getAsyncFunctionConstructor()
            customFunction = new AsyncFunction('opts', baseConfigCustomJavascript.javascript_code)
            try
                customFunction(opts).then((resultValue) ->
                    console.log resultValue
                    if(!resultValue)
                        div.remove()
                        return;

                    if resultValue instanceof Element or resultValue instanceof CUI.Element
                        CUI.dom.append(div, resultValue)
                    else if typeof resultValue == 'string' || resultValue instanceof String
                        div.innerHTML = resultValue
                    else 
                        div.innerHTML = "MaskSplitterCustomJavascript: " + $$("mask.splitter.custom.javascript.message.wrong_function_return_value")
                )
            catch error
                console.error "MaskSplitterCustomJavascript: Error executing custom Javascript:", error.message
        catch error
            console.error "MaskSplitterCustomJavascript: Error when creating Javascript-Function:", error.message
        
        return div

MaskSplitter.plugins.registerPlugin(MaskSplitterCustomJavascript)