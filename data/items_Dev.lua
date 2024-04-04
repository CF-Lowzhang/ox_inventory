return {
    ["whalepic_abilitycard"] = {
        label = " ",
         --'能力晶片卡',
        weight = 20,
        stack = true,
        close = true,
        consume = 1,
        description = "卡片上寫著一行字：訓練微型晶片卡"
    },
    ["whalepic_effectcard"] = {
        label = " ",
         --'特效晶片卡',
        weight = 20,
        stack = true,
        close = true,
        consume = 1,
        description = "卡片上寫著一行字：特效微型晶片卡"
    },
    ["whalepic_specialcard"] = {
        label = " ",
         --'特殊晶片卡',
        weight = 20,
        stack = true,
        close = true,
        consume = 1,
        description = "卡片上寫著一行字：特殊微型晶片卡"
    },
    ["testburger"] = {
        label = " ",
         --'Test Burger',
        weight = 220,
        degrade = 0.2,
        limit = 3,
        client = {
            status = {hunger = 200000},
            anim = "eating",
            prop = "burger",
            usetime = 2500,
            export = "ox_inventory_examples.testburger"
        },
        server = {
            test = "what an amazingly delicious burger, amirite?"
        }
    },

}