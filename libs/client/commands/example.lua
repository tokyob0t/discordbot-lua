return {
    name = 'example',
    description = 'example description',
    options = {
        {
            name = 'first_option',
            description = 'simple description',
            choices = {
                choice_1 = 'value_1',
                choice_2 = 'value_2',
                choice_3 = 'value_3',
            },
        },
        {
            name = 'second_option',
            description = 'simple description',
        },
    },
    callback = function(interaction)
        return interaction:reply('Hi!')
    end,
}
