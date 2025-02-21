local Command = require('utils/command')

local exampleCommand = Command('example', 'example description')

return exampleCommand
    :addStrOption('animal', 'choose one', false, { 'dog', 'cat' })
    :addStrOption('second_option', 'simple description')
    :setCallback(
        ---@param args { animal?: "cat"|"dog", second_option?: string }
        function(interaction, args)
            local msg = 'Hi!'

            if args and args.animal then
                msg = msg .. '\n' .. args.animal
            end

            if args and args.second_option then
                msg = msg .. '\n' .. args.second_option
            end

            interaction:reply(msg)
        end
    )
