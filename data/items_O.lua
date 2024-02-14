return {
    ["o1-1"] = {
        label = " ",
         --'芥末',
        weight = 500,
        client = {
            status = {hunger = 25000, thirst = 25000},
            anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
            prop = {model = "prop_food_mustard", pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5)},
            usetime = 2500,
            notification = "你.. 喝了芥末醬"
        }
    },
    ["o2-1"] = {
        label = " ",
         --'消毒用酒精',
        weight = 20,
        stack = 1,
        close = 1,
        description = ""
    },
    ["o3-1"] = {
        label = " ",
         --'矽膠',
        weight = 20,
        stack = 1,
        close = 1,
        description = ""
    },
    ["o155-1"] = {
        label = " ",
         --'迪化錮',
        weight = 12,
        stack = true,
        close = true
    },
    ["o154-1"] = {
        label = " ",
         --'非晶矽',
        weight = 40,
        stack = true,
        close = true
    },
    ["o153-1"] = {
        label = " ",
         --'米米花',
        weight = 85,
        stack = true,
        close = true,
        client = {
            status = {hunger = 100000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            usetime = 2500
        }
    },
    ["o152-1"] = {
        label = " ",
         --'御果蜂',
        weight = 15,
        stack = true,
        close = true
    },
    ["o151-1"] = {
        label = " ",
         --'海岩苔',
        weight = 15,
        stack = true,
        close = true,
        client = {
            status = {hunger = 5000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004},
                rot = {x = 0.0, y = 0.0, y = 0.0}
            },
            usetime = 2500
        }
    },
    ["o150-1"] = {
        label = " ",
         --'豆腐',
        weight = 100,
        stack = true,
        close = true,
        client = {
            status = {hunger = 125000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004},
                rot = {x = 0.0, y = 0.0, y = 0.0}
            },
            usetime = 2500
        }
    },
    ["o149-1"] = {
        label = " ",
         --'蛋黃醬',
        weight = 150,
        stack = true,
        close = true,
        client = {
            status = {hunger = 185000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004},
                rot = {x = 0.0, y = 0.0, y = 0.0}
            },
            usetime = 2500
        }
    },
    ["o148-1"] = {
        label = " ",
         --'麵包蟲粉',
        weight = 20,
        stack = true,
        close = true
    },
    ["o147-1"] = {
        label = " ",
         --'繡線菊',
        weight = 32,
        stack = true,
        close = true
    },
    ["o146-1"] = {
        label = " ",
         --'柳樹皮',
        weight = 122,
        stack = true,
        close = true
    },
    ["o145-1"] = {
        label = " ",
         --'結晶體',
        weight = 48,
        stack = true,
        close = true
    },
    ["o144-1"] = {
        label = " ",
         --'梨果糖',
        weight = 75,
        stack = true,
        close = true,
        client = {
            status = {thirst = -380000},
            anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
            prop = {
                model = "prop_ecola_can",
                pos = {x = 0.010000000000002, y = 0.010000000000002, y = 0.060000000000002},
                rot = {x = 5.0, y = 5.0, y = -180.5}
            },
            usetime = 2500
        }
    },
    ["o143-1"] = {
        label = " ",
         --'魚油',
        weight = 48,
        stack = true,
        close = true,
        client = {
            status = {hunger = 0},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004},
                rot = {x = 0.0, y = 0.0, y = 0.0}
            },
            usetime = 2500
        }
    },
    ["o142-1"] = {
        label = " ",
         --'布料',
        weight = 21,
        stack = true,
        close = true
    },
    ["o139-1"] = {
        label = " ",
         --'白石',
        weight = 45,
        stack = true,
        close = true
    },
    ["o138-1"] = {
        label = " ",
         --'洗淨的原石',
        weight = 40,
        stack = true,
        close = true,
        client = {
            event = "WhalEpic_General:washedstones"
        }
    },
    ["o137-1"] = {
        label = " ",
         --'異常塑料',
        weight = 999,
        stack = true,
        close = true
    },
    ["o136-1"] = {
        label = " ",
         --'砂糖',
        weight = 10,
        stack = true,
        close = true,
        description = "砂糖"
    },
    ["o135-1"] = {
        label = " ",
         --'醬油',
        weight = 10,
        stack = true,
        close = true,
        description = "醬油"
    },
    ["o134-1"] = {
        label = " ",
         --'花椒',
        weight = 20,
        stack = true,
        close = true,
        description = "花椒"
    },
    ["o133-1"] = {
        label = " ",
         --'鹽',
        weight = 12,
        stack = true,
        close = true,
        description = "鹽",
        client = {
            status = {thirst = -25000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500,
            notification = "你...吃了一整口鹽"
        }
    },
    ["o129-1"] = {
        label = " ",
         --'果菌',
        weight = 81,
        stack = true,
        close = true,
        description = "果菌"
    },
    ["o128-1"] = {
        label = " ",
         --'石油',
        weight = 140,
        stack = true,
        close = true
    },
    ["o126-1"] = {
        label = " ",
         --'金屬原料',
        weight = 250,
        stack = true,
        close = true
    },
    ["o125-1"] = {
        label = " ",
         --'金屬液體',
        weight = 250,
        stack = true,
        close = true
    },
    ["o123-1"] = {
        label = " ",
         --'麵粉',
        weight = 35,
        stack = true,
        close = true,
        description = "麵粉"
    },
    ["o122-1"] = {
        label = " ",
         --'高溫油團',
        weight = 212,
        stack = true,
        close = true
    },
    ["o121-1"] = {
        label = " ",
         --'火藥',
        weight = 45,
        stack = true,
        close = true
    },
    ["o118-1"] = {
        label = " ",
         --'鑽石',
        weight = 55,
        stack = true,
        close = true
    },
    ["o116-1"] = {
        label = " ",
         --'食用油',
        weight = 20,
        stack = true,
        close = true,
        description = "食用油"
    },
    ["o115-1"] = {
        label = " ",
         --'可可粉',
        weight = 5,
        stack = true,
        close = true,
        description = "可可粉"
    },
    ["o114-1"] = {
        label = " ",
         --'可可豆',
        weight = 75,
        stack = true,
        close = true,
        description = "可可豆"
    },
    ["o112-1"] = {
        label = " ",
         --'奶油',
        weight = 14,
        stack = true,
        close = true,
        description = "奶油"
    },
    ["o184-1"] = {
        label = " ",
         --'子彈原料',
        weight = 500,
        stack = true,
        close = true
    },
    ["o109-1"] = {
        label = " ",
         --'魚子醬',
        weight = 213,
        stack = true,
        close = true,
        consume = 1,
        client = {
            status = {hunger = 100000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["o108-1"] = {
        label = " ",
         --'雞腿',
        weight = 45,
        stack = true,
        close = true,
        consume = 1,
        client = {
            status = {hunger = 100000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["o106-1"] = {
        label = " ",
         --'肉桂',
        weight = 20,
        stack = true,
        close = true,
        description = "肉桂",
        consume = 1,
        client = {
            status = {hunger = 500},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["o99-1"] = {
        label = " ",
         --'電解質水',
        weight = 124,
        stack = true,
        close = true,
        consume = 1,
        client = {
            status = {thirst = 200000},
            anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
            prop = {
                model = "prop_ld_flow_bottle",
                pos = {x = 0.03, y = 0.03, z = 0.02},
                rot = {x = 0.0, y = 0.0, z = -1.5}
            },
            usetime = 2500
        }
    },
    ["o94-1"] = {
        label = " ",
         --'焦糖',
        weight = 35,
        stack = true,
        close = true,
        consume = 1,
        client = {
            status = {hunger = 19500},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["o185-1"] = {
        label = " ",
         --'可愛茵',
        weight = 150,
        stack = true,
        close = true,
        consume = 1,
        client = {
            status = {hunger = 2400},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["o81-1"] = {
        label = " ",
         --'番茄醬',
        weight = 50,
        stack = true,
        close = true,
        description = "番茄醬",
        client = {
            status = {thirst = -130000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            usetime = 2500
        }
    },
    ["o80-1"] = {
        label = " ",
         --'寒天粉',
        weight = 100,
        stack = 1,
        description = "寒天粉"
    },
    ["o79-1"] = {
        label = " ",
         --'果凍粉',
        weight = 100,
        stack = 1,
        description = "果凍粉"
    },
    ["o78-1"] = {
        label = " ",
         --'抹茶粉',
        weight = 100,
        stack = 1,
        description = "抹茶粉"
    },
    ["o77-1"] = {
        label = " ",
         --'鮮奶油',
        weight = 50,
        stack = true,
        close = true,
        description = "鮮奶油"
    },
    ["o76-1"] = {
        label = " ",
         --'起司',
        weight = 10,
        stack = true,
        close = true,
        description = "起司",
        consume = 1,
        client = {
            status = {hunger = 3500},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["o70-1"] = {
        label = " ",
         --'乾燥玫瑰',
        weight = 20,
        stack = 1,
        close = 1,
        consume = 1,
        description = "乾燥玫瑰",
        client = {
            status = {hunger = 1000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004},
                rot = {x = 0.0, y = 0.0, y = 0.0}
            },
            usetime = 2500
        }
    },
    ["o66-1"] = {
        label = " ",
         --'薑黃',
        weight = 20,
        stack = 1,
        close = 1,
        consume = 1,
        description = "薑黃",
        client = {
            status = {hunger = 1000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004},
                rot = {x = 0.0, y = 0.0, y = 0.0}
            },
            usetime = 2500
        }
    },
    ["o65-1"] = {
        label = " ",
         --'乾燥小白菊',
        weight = 20,
        stack = 1,
        close = 1,
        consume = 1,
        description = "乾燥小白菊",
        client = {
            status = {hunger = 1000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004},
                rot = {x = 0.0, y = 0.0, y = 0.0}
            },
            usetime = 2500
        }
    },
    ["o63-1"] = {
        label = " ",
         --'餽贈牌醬油',
        weight = 200,
        stack = 1,
        consume = 1,
        description = "餽贈牌醬油",
        client = {
            status = {},
            anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
            prop = {model = "prop_ld_flow_bottle", pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5)},
            usetime = 2500
        }
    },
    ["o61-1"] = {
        label = " ",
         --'無鹽奶油',
        weight = 35,
        stack = 1,
        consume = 1,
        description = "無鹽奶油",
        client = {
            status = {hunger = 1000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004},
                rot = {x = 0.0, y = 0.0, y = 0.0}
            },
            usetime = 2500
        }
    },
    ["o59-1"] = {
        label = " ",
         --'雞',
        weight = 200,
        stack = 1,
        description = ""
    },
    ["o58-1"] = {
        label = " ",
         --'葡萄乾',
        weight = 100,
        stack = true,
        close = true,
        description = "葡萄乾",
        consume = 1,
        client = {
            status = {hunger = 500},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004},
                rot = {x = 0.0, y = 0.0, y = 0.0}
            },
            usetime = 2500
        }
    },
    ["o57-1"] = {
        label = " ",
         --'香草精',
        weight = 150,
        stack = true,
        close = true,
        description = "香草精",
        consume = 1,
        client = {
            status = {thirst = -2500},
            anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
            prop = {model = "prop_food_mustard", pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5)},
            usetime = 2500,
            notification = "你...喝了香草精"
        }
    },
    ["o56-1"] = {
        label = " ",
         --'萊姆酒',
        weight = 500,
        stack = true,
        close = true,
        description = "萊姆酒",
        consume = 1,
        client = {
            status = {thirst = 5000, drunk = 450000},
            anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
            prop = {
                model = "prop_ld_flow_bottle",
                pos = {x = 0.03, y = 0.03, z = 0.02},
                rot = {x = 0.0, y = 0.0, z = -1.5}
            },
            usetime = 4500
        }
    },
    ["o55-1"] = {
        label = " ",
         --'肉桂粉',
        weight = 500,
        stack = true,
        close = true,
        description = "肉桂粉",
        consume = 1,
        client = {
            status = {thirst = 5000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004},
                rot = {x = 0.0, y = 0.0, y = 0.0}
            },
            usetime = 2500
        }
    },
    ["o54-1"] = {
        label = " ",
         --'夏威夷豆',
        weight = 100,
        stack = true,
        close = true,
        description = "夏威夷豆"
    },
    ["o183-1"] = {
        label = " ",
         --'艾酒',
        weight = 200,
        stack = true,
        close = true,
        description = "艾酒",
        consume = 1,
        client = {
            status = {drunk = 105000},
            anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
            prop = {
                model = "prop_ld_flow_bottle",
                pos = {x = 0.03, y = 0.03, z = 0.02},
                rot = {x = 0.0, y = 0.0, z = -1.5}
            },
            usetime = 2500
        }
    },
    ["o182-1"] = {
        label = " ",
         --'糖漿',
        weight = 100,
        stack = true,
        close = true,
        description = "糖漿",
        consume = 1,
        client = {
            status = {thirst = -2500},
            anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
            prop = {model = "prop_food_mustard", pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5)},
            usetime = 2500,
            notification = "嗯...很甜"
        }
    },
    ["o50-1"] = {
        label = " ",
         --'苦精',
        weight = 100,
        stack = true,
        close = true,
        description = "苦精"
    },
    ["o49-1"] = {
        label = " ",
         --'藍橙香甜酒',
        weight = 200,
        stack = true,
        close = true,
        description = "藍橙香甜酒"
    },
    ["o48-1"] = {
        label = " ",
         --'味噌',
        weight = 100,
        stack = true,
        close = true,
        description = "味噌"
    },
    ["o47-1"] = {
        label = " ",
         --'豆腐',
        weight = 100,
        stack = true,
        close = true,
        description = "豆腐"
    },
    ["o45-1"] = {
        label = " ",
         --'味醂',
        weight = 200,
        stack = true,
        close = true,
        description = "味醂"
    },
    ["o44-1"] = {
        label = " ",
         --'黑胡椒',
        weight = 30,
        stack = true,
        close = true,
        description = "黑胡椒"
    },
    ["o43-1"] = {
        label = " ",
         --'松露醬',
        weight = 25,
        stack = true,
        close = true,
        description = "松露醬"
    },
    ["o42-1"] = {
        label = " ",
         --'奶黃醬',
        weight = 25,
        stack = true,
        close = true,
        description = "奶黃醬"
    },
    ["o41-1"] = {
        label = " ",
         --'黃芥末醬',
        weight = 25,
        stack = true,
        close = true,
        description = "黃芥末醬"
    },
    ["o40-1"] = {
        label = " ",
         --'杏仁粉',
        weight = 25,
        stack = true,
        close = true,
        description = "杏仁粉"
    },
    ["o39-1"] = {
        label = " ",
         --'千層酥皮',
        weight = 25,
        stack = true,
        close = true,
        description = "千層酥皮"
    },
    ["o38-1"] = {
        label = " ",
         --'玫瑰花瓣',
        weight = 25,
        stack = true,
        close = true,
        description = "玫瑰花瓣"
    },
    ["o36-1"] = {
        label = " ",
         --'梅干',
        weight = 200,
        stack = 1,
        description = "梅干"
    },
    ["o34-1"] = {
        label = " ",
         --'蛋餅皮',
        weight = 30,
        stack = 1,
        description = "蛋餅皮"
    },
    ["o33-1"] = {
        label = " ",
         --'咖哩塊',
        weight = 30,
        stack = 1,
        description = "咖哩塊"
    },
    ["o32-1"] = {
        label = " ",
         --'綜合鍋物',
        weight = 30,
        stack = 1,
        description = "綜合鍋物"
    },
    ["o31-1"] = {
        label = " ",
         --'精選生菜',
        weight = 30,
        stack = 1,
        description = "精選生菜"
    },
    ["o29-1"] = {
        label = " ",
         --'鬆餅粉',
        weight = 30,
        stack = 1,
        description = "鬆餅粉"
    },
    ["o28-1"] = {
        label = " ",
         --'麵',
        weight = 30,
        stack = 1,
        description = "麵",
        client = {
            status = {hunger = 30000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004},
                rot = {x = 0.0, y = 0.0, y = 0.0}
            },
            usetime = 7000
        }
    },
    ["o27-1"] = {
        label = " ",
         --'小蘇打粉',
        weight = 50,
        stack = 1,
        description = "小蘇打粉"
    },
    ["o26-1"] = {
        label = " ",
         --'奶油乳酪',
        weight = 50,
        stack = 1,
        description = "奶油乳酪"
    },
    ["o25-1"] = {
        label = " ",
         --'麥芽糖',
        weight = 80,
        stack = true,
        close = true,
        description = "麥芽糖"
    },
    ["o24-1"] = {
        label = " ",
         --'花生醬',
        weight = 150,
        stack = true,
        close = true,
        description = "花生醬"
    },
    ["o23-1"] = {
        label = " ",
         --'黑糖',
        weight = 30,
        stack = true,
        close = true,
        description = "黑糖"
    },
    ["o22-1"] = {
        label = " ",
         --'珍珠',
        weight = 50,
        stack = true,
        close = true
    },
    ["o20-1"] = {
        label = " ",
         --'頂級肉肉',
        weight = 20,
        stack = true,
        close = true,
        description = "頂級肉肉"
    },
    ["o18-1"] = {
        label = " ",
         --'紅棗',
        weight = 30,
        stack = 1,
        description = "紅棗"
    },
    ["o16-1"] = {
        label = " ",
         --'白芝麻',
        weight = 60,
        stack = true,
        close = true,
        consume = 0,
        description = "白芝麻",
        client = {}
    },
    ["o15-1"] = {
        label = " ",
         --'Q彈麵',
        weight = 50,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["o13-1"] = {
        label = " ",
         --'年糕',
        weight = 50,
        stack = true,
        close = true,
        consume = 1,
        description = "年糕",
        client = {
            status = {hunger = 50000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 1000,
            notification = ""
        }
    },
    ["o10-1"] = {
        label = " ",
         --'藍色染劑',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["o9-1"] = {
        label = " ",
         --'西谷米',
        weight = 70,
        stack = true,
        close = true,
        consume = 0,
        description = "西谷米",
        client = {}
    },
    ["o7-1"] = {
        label = " ",
         --'愛齊雅祖傳醬汁',
        weight = 50,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {hunger = 80000, thirst = -150000},
            anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
            prop = {
                model = "prop_ld_flow_bottle",
                pos = {x = 0.03, y = 0.03, z = 0.02},
                rot = {x = 0.0, y = 0.0, z = -1.5}
            },
            usetime = 1500,
            notification = ""
        }
    },
    ["o6-1"] = {
        label = " ",
         -- '生烤肉串',
        weight = 170,
        stack = true,
        close = true,
        consume = 1,
        description = "青椒跟牛肉",
        client = {}
    },
    ["o5-1"] = {
        label = " ",
         -- '生蔥肉串',
        weight = 170,
        stack = true,
        close = true,
        consume = 1,
        description = "青蔥跟雞肉",
        client = {}
    },
    ["o4-1"] = {
        label = " ",
         -- '生腿排',
        weight = 170,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {}
    },
    ["o177-1"] = {
        label = " ",
         -- '黑牛',
        weight = 300,
        stack = false,
        close = true,
        consume = 1,
        description = "黑牛",
        client = {
            status = {thirst = 300000},
            anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
            prop = {
                model = "prop_ld_flow_bottle",
                pos = {x = 0.03, y = 0.03, z = 0.02},
                rot = {x = 0.0, y = 0.0, z = -1.5}
            },
            usetime = 1500,
            notification = ""
        }
    },
    ["o178-1"] = {
        label = " ",
         -- '醋',
        weight = 450,
        stack = false,
        close = true,
        consume = 0,
        description = "醋",
        client = {}
    },
    ["o179-1"] = {
        label = " ",
         -- '五穀米',
        weight = 200,
        stack = true,
        close = true,
        consume = 1,
        description = "五穀米",
        client = {}
    },
    ["o180-1"] = {
        label = " ",
         -- '金箔',
        weight = 150,
        stack = true,
        close = true,
        consume = 1,
        description = "金箔",
        client = {}
    },
    ["o181-1"] = {
        label = " ",
         -- '自製花生醬',
        weight = 250,
        stack = false,
        close = true,
        consume = 1,
        description = "",
        client = {}
    },
    ["o149-2"] = {
        label = " ",
         -- '煉乳',
        weight = 350,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {thirst = 100000},
            anim = "drinking",
            prop = "bottle",
            usetime = 1500,
            notification = ""
        }
    },
    ["o156-1"] = {
        label = " ",
         -- '紅葡萄酒',
        weight = 750,
        stack = false,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {thirst = 400000, drunk = 300000},
            anim = "drinking",
            prop = "bottle",
            usetime = 3500,
            notification = ""
        }
    },
    ["o157-1"] = {
        label = " ",
         -- '穀物粉',
        weight = 150,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {hunger = 10000},
            anim = "eating",
            prop = "burger",
            usetime = 1500,
            notification = ""
        }
    },
    ["o158-1"] = {
        label = " ",
         -- '辛香料',
        weight = 150,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {}
    },
    ["o159-1"] = {
        label = " ",
         -- '調味料',
        weight = 150,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {}
    },
    ["o160-1"] = {
        label = " ",
         -- '醬料',
        weight = 350,
        stack = false,
        close = true,
        consume = 1,
        description = "",
        client = {}
    },
    ["o161-1"] = {
        label = " ",
         -- '豐收水晶',
        weight = 10,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["o162-1"] = {
        label = " ",
         -- '望梅水晶',
        weight = 10,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["o163-1"] = {
        label = " ",
         -- '飽滿水晶',
        weight = 10,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["o164-1"] = {
        label = " ",
         -- '味噌罐',
        weight = 25,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["o165-1"] = {
        label = " ",
         -- 'cake粉',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["o33-2"] = {
        label = " ",
         -- '咖哩塊',
        weight = 120,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["o166-1"] = {
        label = " ",
         -- '果醬',
        weight = 160,
        stack = true,
        close = true,
        consume = 0.17,
        description = "",
        client = {
            status = {hunger = 50000, thirst = 30000},
            anim = "eating",
            prop = "burger",
            usetime = 1000,
            notification = "",
            remove = function(total)
                lib.notify({description = ""})
                ExecuteCommand("helpme_giveitem g1_3240_glass 1")
            end
        }
    },
    ["o168-1"] = {
        label = " ",
         -- '綠掛式咖啡包',
        weight = 9,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            usetime = 500,
            notification = "",
            remove = function(total)
                lib.notify({description = "你把咖啡包拆開了"})
                ExecuteCommand("helpme_giveitem g1_9999_cotton 1")
            end
        }
    },
    ["o169-1"] = {
        label = " ",
         -- '草莓果醬',
        weight = 250,
        stack = false,
        close = true,
        consume = 0.19,
        description = "",
        client = {
            status = {hunger = 100000, thirst = 50000},
            anim = "eating",
            prop = "burger",
            usetime = 1500,
            notification = "",
            remove = function(total)
                ExecuteCommand("helpme_giveitem g1_3240_glass 1")
            end
        }
    },
    ["o170-1"] = {
        label = " ",
         -- '米酒',
        weight = 500,
        stack = false,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {drunk = 100000},
            anim = "drinking",
            prop = "bottle",
            usetime = 1500,
            notification = ""
        }
    },
    ["o172-1"] = {
        label = " ",
         -- '地瓜粉',
        weight = 400,
        stack = false,
        close = true,
        consume = 1,
        description = "",
        client = {}
    },
    ["o173-1"] = {
        label = " ",
         -- '玉米粉',
        weight = 400,
        stack = false,
        close = true,
        consume = 1,
        description = "",
        client = {}
    },
    ["o174-1"] = {
        label = " ",
         -- '糯米粉',
        weight = 400,
        stack = false,
        close = true,
        consume = 1,
        description = "",
        client = {}
    },
    ["o176-1"] = {
        label = " ",
         -- '豆腐醬',
        weight = 50,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {hunger = 50000},
            anim = "eating",
            prop = "burger",
            usetime = 500,
            notification = ""
        }
    },
    ["o22-2"] = {
        label = " ",
         -- '珍珠',
        weight = 100,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {hunger = 100000},
            anim = "eating",
            prop = "burger",
            usetime = 1000,
            notification = ""
        }
    }
}
