return {
    ["m2-1"] = {
        label = " ",
         --'餽贈急救包',
        weight = 10,
        stack = true,
        close = true,
        description = ""
    },
    ["m3-1"] = {
        label = " ",
         --'麻醉劑',
        weight = 42,
        stack = 1,
        close = 1,
        description = ""
    },
    ["m4-1"] = {
        label = " ",
         --'雅瑟珮琳',
        weight = 20,
        stack = 1,
        close = 1,
        description = "消炎退燒，具有消炎退燒效果"
    },
    ["m5-1"] = {
        label = " ",
         --'白創藥膏',
        weight = 40,
        stack = 1,
        close = 1,
        description = ""
    },
    ["m6-1"] = {
        label = " ",
         --'痛寧糖漿',
        weight = 75,
        stack = 1,
        close = 1,
        description = ""
    },
    ["m7-1"] = {
        label = " ",
         --'活化精華',
        weight = 50,
        stack = 1,
        close = 1,
        description = ""
    },
    ["m8-1"] = {
        label = " ",
         --'眼藥水',
        weight = 50,
        stack = 1,
        close = 1,
        description = "",
        client = {
            usetime = 2500
        }
    },
    ["m9-1"] = {
        label = " ",
         --'葡萄糖錠',
        weight = 15,
        stack = 1,
        close = 1,
        description = "",
        client = {
            status = {hunger = 5000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            usetime = 2500
        }
    },
    ["m10-1"] = {
        label = " ",
         --'心橋碇',
        weight = 20,
        stack = 1,
        close = 0,
        description = ""
    },
    ["m11-1"] = {
        label = " ",
         --'茵草膏',
        weight = 50,
        stack = 1,
        close = 1,
        description = ""
    },
    ["m12-1"] = {
        label = " ",
         --'許普諾錠',
        weight = 48,
        stack = 1,
        close = 1,
        description = ""
    },
    ["m1-1"] = {
        label = " ",
         --'特效藥',
        weight = 300,
        stack = 1,
        close = 1,
        description = "",
        client = {
            usetime = 2500
        }
        -- client = {
        --   status = {},
        --   anim = { dict = 'wolf@awesome@asset', clip = 'pill' },
        --   -- prop = { model = 'prop_cs_burger_01', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
        --   usetime = 2500,
        -- }
    },
    ["m14-1"] = {
        label = " ",
         --'醫療包',
        weight = 10,
        stack = true,
        close = true,
        description = "",
        client = {
            anim = {dict = "missheistdockssetup1clipboard@idle_a", clip = "idle_a", flag = 49},
            prop = {model = "prop_rolled_sock_02", pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0)},
            disable = {move = true, car = true, combat = true},
            usetime = 2500
        }
    },
    ["m15-1"] = {
        label = " ",
         --'綜合維生素',
        weight = 14,
        stack = 1,
        close = 1,
        description = ""
    },
    ["m16-1"] = {
        label = " ",
         --'複合型營養劑',
        weight = 120,
        stack = 1,
        close = 1,
        description = ""
    },
    ["m17-1"] = {
        label = " ",
         --'皮膚過敏藥膏',
        weight = 50,
        stack = 1,
        close = 1,
        description = "",
        client = {
            usetime = 2500
        }
    },
    ["m18-1"] = {
        label = " ",
         --'ok繃',
        weight = 10,
        stack = 1,
        close = 1,
        description = ""
    },
    ["m19-1"] = {
        label = " ",
         --'止痛藥',
        weight = 24,
        stack = 1,
        close = 1,
        description = "止痛藥",
        client = {
            status = {drunk = 100},
            anim = {dict = "wolf@awesome@asset", clip = "pill"},
            usetime = 2500
        }
    },
    ["m20-1"] = {
        label = " ",
         --'藥膏貼布',
        weight = 23,
        stack = 1,
        close = 1,
        description = ""
    },
    ["m21-1"] = {
        label = " ",
         --'生理食鹽水',
        weight = 20,
        stack = 1,
        close = 1,
        description = ""
    },
    ["m22-1"] = {
        label = " ",
         --'吸入噴劑',
        weight = 20,
        stack = 1,
        close = 1,
        description = ""
    },
    ["m23-1"] = {
        label = " ",
         --'疫苗',
        weight = 500,
        stack = 1,
        close = 1,
        description = ""
    },
    ["m37-1"] = {
        label = " ",
         --'魚油錠',
        weight = 10,
        stack = true,
        close = true,
        client = {
            status = {hunger = 200000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            usetime = 1000
        }
    },
    ["m36-1"] = {
        label = " ",
         --'二酚外傷藥膏(new)',
        weight = 20,
        stack = true,
        close = true,
        description = "使用後需盡快用紗布包裹患部！",
        client = {
            anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
            usetime = 7500
        }
    },
    ["m35-1"] = {
        label = " ",
         --'二酚外傷藥膏',
        weight = 20,
        stack = true,
        close = true,
        description = "使用後需盡快用紗布包裹患部！",
        client = {
            anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
            usetime = 7500
        }
    },
    ["m38-1"] = {
        label = " ",
         --'解酒液',
        weight = 250,
        stack = true,
        close = true,
        consume = 1,
        client = {
            status = {drunk = -500000},
            anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
            prop = {
                model = "prop_ld_flow_bottle",
                pos = {x = 0.03, y = 0.03, z = 0.02},
                rot = {x = 0.0, y = 0.0, z = -1.5}
            },
            usetime = 2500
        }
    },
    ["m34-1"] = {
        label = " ",
         --'碘酒',
        weight = 124,
        stack = true,
        close = true
    },
    ["m33-1"] = {
        label = " ",
         --'葡萄糖',
        weight = 24,
        stack = true,
        close = true,
        client = {
            usetime = 2500
        }
    },
    ["m32-1"] = {
        label = " ",
         --'血袋',
        weight = 250,
        stack = true,
        close = true
    },
    ["m30-1"] = {
        label = " ",
         --'噴暈藥水',
        weight = 110,
        stack = true,
        close = true,
        consume = 1,
        description = "不知名藥水，只貼著噴暈藥水。",
        client = {
            status = {thirst = 10000},
            anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
            prop = {model = "prop_ld_flow_bottle", pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5)},
            usetime = 2500
        }
    },
    ["m29-1"] = {
        label = " ",
         --'餽贈特製安眠藥',
        weight = 20,
        stack = 1,
        consume = 1,
        description = "",
        client = {
            status = {},
            anim = {dict = "wolf@awesome@asset", clip = "pill"},
            -- prop = { model = 'prop_cs_burger_01', pos = { x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004}, rot = { x = 0.0, y = 0.0, y = 0.0} },
            usetime = 2500
        }
    },
    ["m28-1"] = {
        label = " ",
         --'耐絞寧舌下錠',
        weight = 5,
        stack = 1,
        description = "",
        client = {
            status = {},
            anim = {dict = "wolf@awesome@asset", clip = "pill"},
            -- prop = { model = 'prop_ld_flow_bottle', pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
            usetime = 2500
        }
    },
    ["m27-1"] = {
        label = " ",
         --'氣管擴張劑',
        weight = 200,
        stack = 1,
        description = "",
        client = {
            status = {},
            anim = {dict = "wolf@awesome@asset", clip = "pill"},
            -- prop = { model = 'prop_ld_flow_bottle', pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
            usetime = 2500
        }
    },
    ["m26-1"] = {
        label = " ",
         --'百憂解',
        weight = 100,
        stack = 1,
        close = 1,
        consume = 1,
        description = "精神科藥物",
        client = {
            usetime = 2500
        }
    },
    ["m24-1"] = {
        label = " ",
         --'單管血液樣本',
        weight = 120,
        stack = true,
        close = true,
        consume = 1,
        client = {
            status = {},
            usetime = 3500
        }
    },
    ["m2-2"] = {
        label = " ",
         -- '急救包',
        weight = 350,
        stack = false,
        close = true,
        consume = 1,
        description = "",
        client = {}
    },
    ["m39-1"] = {
        label = " ",
         -- '酒精棉片',
        weight = 5,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            usetime = 200,
            notification = "已消毒"
        }
    },
    ["m19-2"] = {
        label = " ",
         -- '止痛藥',
        weight = 50,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            anim = {dict = "wolf@awesome@asset", clip = "pill"},
            usetime = 1500,
            notification = "疼痛被緩解了"
        }
    },
    ["m40-1"] = {
        label = " ",
         -- '抗生素',
        weight = 50,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            anim = {dict = "wolf@awesome@asset", clip = "pill"},
            usetime = 1500,
            notification = ""
        }
    },
    ["m41-1"] = {
        label = " ",
         -- '安眠藥',
        weight = 50,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            anim = {dict = "wolf@awesome@asset", clip = "pill"},
            usetime = 1500,
            notification = ""
        }
    },
    ["m42-1"] = {
        label = " ",
         -- '胰島素筆',
        weight = 50,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            anim = {dict = "missheistdockssetup1clipboard@idle_a", clip = "idle_a", flag = 49},
            prop = {model = "prop_pencil_01", pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0)},
            disable = {move = true, car = true, combat = true},
            usetime = 2500,
            notification = "疲勞消除"
        }
    },
    ["m43-1"] = {
        label = " ",
         -- '抗憂鬱藥',
        weight = 50,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            anim = {dict = "wolf@awesome@asset", clip = "pill"},
            usetime = 1500,
            notification = ""
        }
    },
    ["m44-1"] = {
        label = " ",
         -- '維生素',
        weight = 50,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            anim = {dict = "wolf@awesome@asset", clip = "pill"},
            usetime = 1500,
            notification = ""
        }
    },
    ["m45-1"] = {
        label = " ",
         -- '美樂蒂醫療包',
        weight = 300,
        stack = false,
        close = true,
        consume = 1,
        description = "醫療包內有3組繃帶，５包感冒藥，１罐碘酒，１罐消炎水",
        client = {
            usetime = 500
        }
    },
    ["m46-1"] = {
        label = " ",
         -- '嗎啡粉',
        weight = 150,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {drunk = 50000},
            usetime = 500,
            notification = "捲起來抽"
        }
    },
    ["m47-1"] = {
        label = " ",
         -- '疫苗',
        weight = 200,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            notification = ""
        }
    },
    ["m20-2"] = {
        label = " ",
         --'藥膏貼布',
        weight = 500,
        stack = true,
        close = true,
        consume = 1,
        client = {
            usetime = 500
        }
    },
    ["m25-1"] = {
        label = " ",
         --'取血針',
        weight = 10,
        stack = true,
        close = true,
        consume = 1,
        client = {
            status = {},
            usetime = 3500
        }
    },
}
