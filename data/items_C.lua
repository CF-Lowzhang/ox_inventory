return {
    ["c6-1"] = {
        label = " ",
         --'水',
        weight = 200,
        consume = 1,
        description = "雨水",
        client = {
            status = {thirst = 150000},
            anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
            prop = {model = "prop_ld_flow_bottle", pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5)},
            usetime = 2500,
            cancel = true,
            notification = "喝了雨水"
        }
    },
    ["c7-1"] = {
        label = " ",
         --'水',
        weight = 500,
        consume = 1,
        description = "水",
        client = {
            status = {thirst = 150000},
            anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
            prop = {model = "prop_ld_flow_bottle", pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5)},
            usetime = 2500,
            cancel = true,
            notification = "喝了新鮮的水"
        }
    },
    ["c8-1"] = {
        label = " ",
         --'黑百合',
        weight = 22,
        stack = 1,
        close = 1,
        description = ""
    },
    ["c9-1"] = {
        label = " ",
         --'黑鈴蘭',
        weight = 21,
        stack = 1,
        close = 1,
        description = ""
    },
    ["c10-1"] = {
        label = " ",
         --'海蘭花',
        weight = 42,
        stack = 1,
        close = 1,
        description = "海蘭花"
    },
    ["c11-1"] = {
        label = " ",
         --'雜草',
        weight = 32,
        stack = 1,
        close = 1,
        description = ""
    },
    ["c12-1"] = {
        label = " ",
         --'櫻花',
        weight = 60,
        stack = 1,
        close = 1,
        description = "櫻花"
    },
    ["c13-1"] = {
        label = " ",
         --'惑心花',
        weight = 13,
        stack = 1,
        close = 1,
        description = ""
    },
    ["c14-1"] = {
        label = " ",
         --'未知血塊',
        weight = 87,
        stack = 1,
        close = 1,
        description = ""
    },
    ["c15-1"] = {
        label = " ",
         --'茵草',
        weight = 21,
        stack = 1,
        close = 1,
        description = "草本植物，葉子羽狀分裂，有特殊的香味可以驅趕蚊蟲，帶有苦味，葉子有著止咳、止瀉、止吐的功效。"
    },
    ["c16-1"] = {
        label = " ",
         --'彼岸花',
        weight = 32,
        stack = 1,
        close = 1,
        description = ""
    },
    ["c17-1"] = {
        label = " ",
         --'鳳仙花',
        weight = 24,
        stack = 1,
        close = 1,
        description = ""
    },
    ["c19-1"] = {
        label = " ",
         --'香蕉',
        weight = 96,
        stack = 1,
        close = 1,
        description = "香蕉",
        client = {
            usetime = 2500
        }
    },
    ["c20-1"] = {
        label = " ",
         --'幸福櫻桃',
        weight = 86,
        stack = 1,
        close = 1,
        description = "",
        client = {
            usetime = 2500
        }
    },
    ["c1-1"] = {
        label = " ",
         --'葡萄',
        weight = 95,
        stack = 1,
        close = 1,
        description = "",
        client = {
            usetime = 2500
        }
    },
    ["c2-1"] = {
        label = " ",
         --'檸檬',
        weight = 86,
        stack = 1,
        close = 1,
        description = "",
        client = {
            usetime = 2500
        }
    },
    ["c21-1"] = {
        label = " ",
         --'芒果',
        weight = 87,
        stack = 1,
        close = 1,
        description = "芒果",
        client = {
            usetime = 2500
        }
    },
    ["c22-1"] = {
        label = " ",
         --'番茄',
        weight = 85,
        stack = 1,
        close = 1,
        description = "番茄",
        client = {
            usetime = 2500
        }
    },
    ["c23-1"] = {
        label = " ",
         --'開心番茄',
        weight = 94,
        stack = 1,
        close = 1,
        description = "",
        client = {
            usetime = 2500
        }
    },
    ["c24-1"] = {
        label = " ",
         --'曼陀羅',
        weight = 34,
        stack = 1,
        close = 1,
        description = "",
        client = {
            usetime = 2500
        }
    },
    ["c25-1"] = {
        label = " ",
         --'朝霧玫瑰',
        weight = 32,
        stack = 1,
        close = 1,
        description = "朝霧玫瑰"
    },
    ["c26-1"] = {
        label = " ",
         --'鈴蘭花',
        weight = 21,
        stack = 1,
        close = 1,
        description = ""
    },
    ["c27-1"] = {
        label = " ",
         --'神秘藥草',
        weight = 22,
        stack = 1,
        close = 1,
        description = ""
    },
    ["c28-1"] = {
        label = " ",
         --'櫻花草',
        weight = 45,
        stack = 1,
        close = 1,
        description = "櫻花草"
    },
    ["c29-1"] = {
        label = " ",
         --'八重紅花',
        weight = 21,
        stack = 1,
        close = 1,
        description = "將莖部取下曬乾後磨成粉，有止痛的療效。但直接生用會導致中毒。"
    },
    ["c30-1"] = {
        label = " ",
         --'燕尾花',
        weight = 18,
        stack = 1,
        close = 1,
        description = ""
    },
    ["c31-1"] = {
        label = " ",
         --'怪異植物',
        weight = 95,
        stack = 1,
        close = 1,
        description = ""
    },
    ["c32-1"] = {
        label = " ",
         --'琥珀',
        weight = 100,
        stack = true,
        close = true
    },
    ["c33-1"] = {
        label = " ",
         --'七彩琥珀',
        weight = 100,
        stack = true,
        close = true
    },
    ["c34-1"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["c35-1"] = {
        label = " ",
         --'樺木',
        weight = 100,
        stack = true,
        close = true
    },
    ["c36-1"] = {
        label = " ",
         --'檜木',
        weight = 100,
        stack = true,
        close = true
    },
    ["c37-1"] = {
        label = " ",
         --'朽木',
        weight = 100,
        stack = true,
        close = true
    },
    ["c38-1"] = {
        label = " ",
         --'白沙',
        weight = 50,
        stack = true,
        close = true
    },
    ["c39-1"] = {
        label = " ",
         --'紅沙',
        weight = 50,
        stack = true,
        close = true
    },
    ["c40-1"] = {
        label = " ",
         --'黑沙',
        weight = 50,
        stack = true,
        close = true
    },
    ["c41-1"] = {
        label = " ",
         --'荷葉',
        weight = 20,
        stack = true,
        close = true
    },
    ["c42-1"] = {
        label = " ",
         --'蓮花',
        weight = 20,
        stack = true,
        close = true
    },
    ["c3-1"] = {
        label = " ",
         --'迷迭香',
        weight = 74,
        stack = true,
        close = true,
        description = "迷迭香"
    },
    ["c93-1"] = {
        label = " ",
         --'紫鑽',
        weight = 200,
        stack = true,
        close = true
    },
    ["c92-1"] = {
        label = " ",
         --'旋果蚊子草',
        weight = 21,
        stack = true,
        close = true
    },
    ["c91-1"] = {
        label = " ",
         --'粉色海草',
        weight = 42,
        stack = true,
        close = true,
        description = "粉色海草"
    },
    ["c90-1"] = {
        label = " ",
         --'海鹽',
        weight = 25,
        stack = true,
        close = true
    },
    ["c89-1"] = {
        label = " ",
         --'樹脂',
        weight = 40,
        stack = true,
        close = true
    },
    ["c88-1"] = {
        label = " ",
         --'昆蟲',
        weight = 4,
        stack = true,
        close = true,
        consume = 1,
        client = {
            status = {hunger = 2000, thirst = 2000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500,
            notification = "嘎崩脆"
        }
    },
    ["c64-1"] = {
        label = " ",
         --'野莓',
        weight = 74,
        stack = true,
        close = true,
        description = "野莓",
        consume = 1,
        client = {
            status = {hunger = 25000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c87-1"] = {
        label = " ",
         --'木頭',
        weight = 80,
        stack = true,
        close = true
    },
    ["c86-1"] = {
        label = " ",
         --'鯨魚骨頭',
        weight = 5000,
        stack = true,
        close = true
    },
    ["c85-1"] = {
        label = " ",
         --'甘蔗',
        weight = 15,
        stack = true,
        close = true
    },
    ["c84-1"] = {
        label = " ",
         --'石頭',
        weight = 40,
        stack = true,
        close = true,
        client = {
            event = "WhalEpic_General:stones"
        }
    },
    ["c83-1"] = {
        label = " ",
         --'銀礦',
        weight = 200,
        stack = true,
        close = true
    },
    ["c81-1"] = {
        label = " ",
         --'沙子',
        weight = 20,
        stack = true,
        close = true
    },
    ["c80-1"] = {
        label = " ",
         --'玫瑰鹽',
        weight = 17,
        stack = true,
        close = true,
        description = "玫瑰鹽"
    },
    ["c5-2"] = {
        label = " ",
         --'骨頭',
        weight = 150,
        stack = true,
        close = true
    },
    ["c148-1"] = {
        label = " ",
         --'洋蔥',
        weight = 20,
        stack = true,
        close = true,
        description = "洋蔥"
    },
    ["c78-1"] = {
        label = " ",
         --'礦鹽',
        weight = 225,
        stack = true,
        close = true
    },
    ["c187-1"] = {
        label = " ",
         --'卡塔亞瑪石',
        weight = 70,
        stack = true,
        close = true
    },
    ["c77-1"] = {
        label = " ",
         --'鐵礦',
        weight = 200,
        stack = true,
        close = true
    },
    ["c76-1"] = {
        label = " ",
         --'蛇麻',
        weight = 42,
        stack = true,
        close = true
    },
    ["c184-1"] = {
        label = " ",
         --'灰鐵石',
        weight = 70,
        stack = true,
        close = true
    },
    ["c75-1"] = {
        label = " ",
         --'金礦',
        weight = 100,
        stack = true,
        close = true
    },
    ["c183-1"] = {
        label = " ",
         --'蛋',
        weight = 20,
        stack = true,
        close = true,
        description = "蛋"
    },
    ["c182-1"] = {
        label = " ",
         --'玉米',
        weight = 27,
        stack = true,
        close = true,
        description = "玉米"
    },
    ["c74-1"] = {
        label = " ",
         --'銅礦',
        weight = 30,
        stack = true,
        close = true
    },
    ["c73-1"] = {
        label = " ",
         --'煤礦',
        weight = 30,
        stack = true,
        close = true
    },
    ["c72-1"] = {
        label = " ",
         --'藍貝',
        weight = 112,
        stack = true,
        close = true,
        description = "可產出「藍珠」的貝類，生長在淺海區。"
    },
    ["c181-1"] = {
        label = " ",
         --'羅勒',
        weight = 20,
        stack = true,
        close = true,
        description = "羅勒"
    },
    ["c180-1"] = {
        label = " ",
         --'蜀葵',
        weight = 50,
        stack = true,
        close = true
    },
    ["c71-1"] = {
        label = " ",
         --'動物組織',
        weight = 53,
        stack = true,
        close = true
    },
    ["c70-1"] = {
        label = " ",
         --'莓果',
        weight = 66,
        stack = true,
        close = true,
        consume = 1,
        description = "莓果",
        client = {
            status = {hunger = 20000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c142-1"] = {
        label = " ",
         --'辣椒',
        weight = 17,
        stack = true,
        close = true,
        description = "辣椒",
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
    ["c179-1"] = {
        label = " ",
         --'墨魚',
        weight = 250,
        stack = true,
        close = true,
        description = "墨魚",
        consume = 1,
        client = {
            status = {hunger = 20000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c178-1"] = {
        label = " ",
         --'螃蟹',
        weight = 250,
        stack = true,
        close = true,
        description = "螃蟹",
        consume = 1,
        client = {
            status = {hunger = 1500},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c177-1"] = {
        label = " ",
         --'海鰻',
        weight = 250,
        stack = true,
        close = true,
        description = "海鰻",
        consume = 1,
        client = {
            status = {hunger = 1650},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c175-1"] = {
        label = " ",
         --'魚',
        weight = 200,
        stack = true,
        close = true,
        description = "魚",
        consume = 1,
        client = {
            status = {hunger = 7400},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c1-2"] = {
        label = " ",
         --'葡萄',
        weight = 21,
        stack = true,
        close = true,
        description = "葡萄",
        consume = 1,
        client = {
            status = {hunger = 1000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c174-1"] = {
        label = " ",
         --'蜂蜜',
        weight = 100,
        stack = true,
        close = true,
        description = "蜂蜜",
        consume = 1,
        client = {
            status = {hunger = 45000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c173-1"] = {
        label = " ",
         --'冰',
        weight = 24,
        stack = true,
        close = true,
        consume = 1,
        client = {
            status = {thirst = 4200},
            usetime = 100
        }
    },
    ["c172-1"] = {
        label = " ",
         --'水母',
        weight = 250,
        stack = true,
        close = true,
        consume = 1,
        client = {
            status = {hunger = -10000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c2-3"] = {
        label = " ",
         --'檸檬',
        weight = 81,
        stack = true,
        close = true,
        consume = 1,
        client = {
            status = {hunger = 9000, thirst = -3000},
            anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_ld_flow_bottle",
                pos = {x = 0.03, y = 0.03, z = 0.02},
                rot = {x = 0.0, y = 0.0, z = -1.5}
            },
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c69-1"] = {
        label = " ",
         --'小黃瓜',
        weight = 57,
        stack = true,
        close = true,
        description = "小黃瓜",
        consume = 1,
        client = {
            status = {hunger = 9500},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c68-1"] = {
        label = " ",
         --'龍蝦',
        weight = 250,
        stack = true,
        close = true,
        description = "龍蝦",
        consume = 1,
        client = {
            status = {hunger = 72400},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c171-1"] = {
        label = " ",
         --'松茸',
        weight = 47,
        stack = true,
        close = true,
        consume = 1,
        client = {
            status = {hunger = 4500},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c188-1"] = {
        label = " ",
         --'牛奶',
        weight = 100,
        stack = true,
        close = true,
        description = "牛奶",
        consume = 1,
        client = {
            status = {thirst = 80000},
            anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
            prop = {
                model = "prop_ld_flow_bottle",
                pos = {x = 0.03, y = 0.03, z = 0.02},
                rot = {x = 0.0, y = 0.0, z = -1.5}
            },
            usetime = 2500
        }
    },
    ["c67-1"] = {
        label = " ",
         --'梨子',
        weight = 48,
        stack = true,
        close = true,
        description = "梨子",
        consume = 1,
        client = {
            status = {hunger = 7500},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c145-1"] = {
        label = " ",
         --'馬鈴薯',
        weight = 72,
        stack = true,
        close = true,
        description = "馬鈴薯",
        consume = 1,
        client = {
            status = {hunger = 12500},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c143-1"] = {
        label = " ",
         --'蝦',
        weight = 250,
        stack = true,
        close = true,
        description = "蝦",
        consume = 1,
        client = {
            status = {hunger = 4500},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c170-1"] = {
        label = " ",
         --'高粱',
        weight = 60,
        stack = true,
        close = true,
        description = "",
        consume = 1,
        client = {
            status = {hunger = 6542},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c169-1"] = {
        label = " ",
         --'大豆',
        weight = 75,
        stack = true,
        close = true,
        description = "大豆",
        consume = 1,
        client = {
            status = {hunger = 3241},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c168-1"] = {
        label = " ",
         --'茶葉',
        weight = 11,
        stack = true,
        close = true,
        description = "茶葉",
        consume = 1,
        client = {
            status = {hunger = 2500},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c66-1"] = {
        label = " ",
         --'綜合蔬菜',
        weight = 85,
        stack = true,
        close = true,
        description = "綜合蔬菜",
        consume = 1,
        client = {
            status = {hunger = 5000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c65-1"] = {
        label = " ",
         --'小麥',
        weight = 65,
        stack = true,
        close = true,
        description = "小麥",
        consume = 1,
        client = {
            status = {hunger = 3000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c64-1"] = {
        label = " ",
         --'野莓',
        weight = 74,
        stack = true,
        close = true,
        description = "野莓",
        consume = 1,
        client = {
            status = {hunger = 4500},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c4-2"] = {
        label = " ",
         --'石英',
        weight = 50,
        stack = true,
        close = true
    },
    ["c167-1"] = {
        label = " ",
         --'矽石',
        weight = 50,
        stack = true,
        close = true
    },
    ["c63-1"] = {
        label = " ",
         --'聖女番茄',
        weight = 100,
        stack = true,
        close = true,
        description = "聖女番茄",
        client = {
            status = {hunger = 6500},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            usetime = 2500
        }
    },
    ["c62-1"] = {
        label = " ",
         --'胡蘿蔔',
        weight = 40,
        stack = true,
        close = true,
        description = "胡蘿蔔",
        client = {
            status = {hunger = 6500},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            usetime = 2500
        }
    },
    ["c61-1"] = {
        label = " ",
         --'麵包蟲',
        weight = 2,
        stack = true,
        close = true,
        consume = 1,
        client = {
            status = {hunger = 2000, thirst = 12000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500,
            notification = "鮮嫩多汁"
        }
    },
    ["c60-1"] = {
        label = " ",
         --'棉花',
        weight = 0,
        stack = true,
        description = "棉花"
    },
    ["c59-1"] = {
        label = " ",
         --'向日葵花瓣',
        weight = 10,
        stack = 1,
        description = "向日葵花瓣"
    },
    ["c58-1"] = {
        label = " ",
         --'草莓',
        weight = 100,
        stack = 1,
        description = "草莓",
        client = {
            status = {hunger = 10000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            usetime = 2500
        }
    },
    ["c57-1"] = {
        label = " ",
         --'章魚',
        weight = 100,
        stack = 1,
        consume = 1,
        description = "章魚",
        client = {
            status = {hunger = 10000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004},
                rot = {x = 0.0, y = 0.0, y = 0.0}
            },
            usetime = 2500
        }
    },
    ["c56-1"] = {
        label = " ",
         --'杏仁',
        weight = 100,
        stack = 1,
        consume = 1,
        description = "杏仁",
        client = {
            status = {hunger = 10000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004},
                rot = {x = 0.0, y = 0.0, y = 0.0}
            },
            usetime = 2500
        }
    },
    ["c55-1"] = {
        label = " ",
         --'藍莓',
        weight = 100,
        stack = 1,
        consume = 1,
        description = "藍莓",
        client = {
            status = {hunger = 10000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004},
                rot = {x = 0.0, y = 0.0, y = 0.0}
            },
            usetime = 2500
        }
    },
    ["c54-1"] = {
        label = " ",
         --'柳橙',
        weight = 30,
        stack = 1,
        close = 1,
        consume = 1,
        description = "柳橙",
        client = {
            status = {hunger = 10000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004},
                rot = {x = 0.0, y = 0.0, y = 0.0}
            },
            usetime = 2500
        }
    },
    ["c53-1"] = {
        label = " ",
         --'百香果',
        weight = 30,
        stack = 1,
        close = 1,
        consume = 1,
        description = "百香果",
        client = {
            status = {hunger = 10000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004},
                rot = {x = 0.0, y = 0.0, y = 0.0}
            },
            usetime = 2500
        }
    },
    ["c52-1"] = {
        label = " ",
         --'蘋果',
        weight = 30,
        stack = 1,
        close = 1,
        consume = 1,
        description = "蘋果",
        client = {
            status = {hunger = 10000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004},
                rot = {x = 0.0, y = 0.0, y = 0.0}
            },
            usetime = 2500
        }
    },
    ["c166-1"] = {
        label = " ",
         --'艾草',
        weight = 30,
        stack = 1,
        close = 1,
        consume = 1,
        description = "艾草",
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
    ["c165-1"] = {
        label = " ",
         --'薄荷葉',
        weight = 20,
        stack = 1,
        close = 1,
        consume = 1,
        description = "薄荷葉",
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
    ["c164-1"] = {
        label = " ",
         --'靈芝',
        weight = 20,
        stack = 1,
        close = 1,
        consume = 1,
        description = "靈芝",
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
    ["c163-1"] = {
        label = " ",
         --'紫蘇',
        weight = 20,
        stack = 1,
        close = 1,
        consume = 1,
        description = "紫蘇",
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
    ["c162-1"] = {
        label = " ",
         --'生薑',
        weight = 20,
        stack = 1,
        close = 1,
        consume = 1,
        description = "生薑",
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
    ["c161-1"] = {
        label = " ",
         --'蘆薈',
        weight = 20,
        stack = 1,
        close = 1,
        consume = 1,
        description = "蘆薈",
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
    ["c160-1"] = {
        label = " ",
         --'百合球莖',
        weight = 20,
        stack = 1,
        close = 1,
        consume = 1,
        description = "百合球莖",
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
    ["c159-1"] = {
        label = " ",
         --'仙人掌果',
        weight = 20,
        stack = 1,
        close = 1,
        consume = 1,
        description = "仙人掌果",
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
    ["c3-2"] = {
        label = " ",
         --'迷迭香',
        weight = 20,
        stack = 1,
        close = 1,
        consume = 1,
        description = "迷迭香",
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
    ["c158-1"] = {
        label = " ",
         --'馬鞭草',
        weight = 20,
        stack = 1,
        close = 1,
        consume = 1,
        description = "馬鞭草",
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
    ["c51-1"] = {
        label = " ",
         --'鳳梨',
        weight = 200,
        stack = 1,
        consume = 1,
        description = "鳳梨",
        client = {
            status = {hunger = 100000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004},
                rot = {x = 0.0, y = 0.0, y = 0.0}
            },
            usetime = 2500
        }
    },
    ["c189-1"] = {
        label = " ",
         --'蔓越莓',
        weight = 20,
        stack = 1,
        consume = 1,
        description = "蔓越莓",
        client = {
            status = {hunger = 10000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004},
                rot = {x = 0.0, y = 0.0, y = 0.0}
            },
            usetime = 2500
        }
    },
    ["c186-1"] = {
        label = " ",
         --'奇異果',
        weight = 20,
        stack = 1,
        consume = 1,
        description = "奇異果",
        client = {
            status = {hunger = 10000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.020000000000004, y = 0.020000000000004, y = -0.020000000000004},
                rot = {x = 0.0, y = 0.0, y = 0.0}
            },
            usetime = 2500
        }
    },
    ["c157-1"] = {
        label = " ",
         --'覆盆莓',
        weight = 100,
        stack = true,
        close = true,
        description = "覆盆莓"
    },
    ["c156-1"] = {
        label = " ",
         --'香菇',
        weight = 100,
        stack = true,
        close = true,
        description = "香菇"
    },
    ["c2-2"] = {
        label = " ",
         --'檸檬',
        weight = 50,
        stack = true,
        close = true,
        description = "檸檬"
    },
    ["c147-1"] = {
        label = " ",
         --'橄欖',
        weight = 100,
        stack = true,
        close = true,
        description = "橄欖"
    },
    ["c144-1"] = {
        label = " ",
         --'蔥',
        weight = 100,
        stack = true,
        close = true,
        description = "蔥"
    },
    ["c155-1"] = {
        label = " ",
         --'雞肉',
        weight = 200,
        stack = 1,
        description = "雞肉"
    },
    ["c154-1"] = {
        label = " ",
         --'地瓜',
        weight = 30,
        stack = 1,
        description = "地瓜"
    },
    ["c46-1"] = {
        label = " ",
         --'紫羅蘭',
        weight = 50,
        stack = true,
        close = true,
        description = "紫羅蘭",
        consume = 0,
        client = {}
    },
    ["c47-1"] = {
        label = " ",
         --'藍紫羅蘭',
        weight = 50,
        stack = true,
        close = true,
        description = "藍紫羅蘭",
        consume = 0,
        client = {}
    },
    ["c48-1"] = {
        label = " ",
         --'白百合',
        weight = 50,
        stack = true,
        close = true,
        description = "白百合",
        consume = 0,
        client = {}
    },
    ["c49-1"] = {
        label = " ",
         --'粉紅玫瑰',
        weight = 50,
        stack = true,
        close = true,
        description = "粉紅玫瑰",
        consume = 0,
        client = {}
    },
    ["c50-1"] = {
        label = " ",
         --'滿天星',
        weight = 50,
        stack = true,
        close = true,
        description = "滿天星",
        consume = 0,
        client = {}
    },
    ["c153-1"] = {
        label = " ",
         --'桂圓',
        weight = 30,
        stack = 1,
        description = "桂圓"
    },
    ["c152-1"] = {
        label = " ",
         --'紅豆',
        weight = 30,
        stack = 1,
        description = "紅豆"
    },
    ["c45-1"] = {
        label = " ",
         --'玫瑰',
        weight = 32,
        stack = 1,
        close = 1,
        description = "玫瑰"
    },
    ["c44-1"] = {
        label = " ",
         --'牛肉',
        weight = 50,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["c141-7"] = {
        label = " ",
         --'芋頭',
        weight = 200,
        stack = true,
        close = true,
        consume = 1,
        description = "芋頭",
        client = {
            status = {hunger = 150000},
            anim = "eating",
            prop = "burger",
            usetime = 1500,
            notification = ""
        }
    },
    ["c151-1"] = {
        label = " ",
         --'綠豆',
        weight = 30,
        stack = true,
        close = true,
        consume = 0,
        description = "綠豆",
        client = {}
    },
    ["c150-1"] = {
        label = " ",
         --'花椰菜',
        weight = 30,
        stack = true,
        close = true,
        consume = 0,
        description = "花椰菜",
        client = {}
    },
    ["c149-1"] = {
        label = " ",
         --'蒜頭',
        weight = 50,
        stack = true,
        close = true,
        consume = 0,
        description = "蒜頭",
        client = {}
    },
    ["c43-1"] = {
        label = " ",
         -- '玫瑰花束',
        weight = 250,
        stack = true,
        close = true,
        consume = 0,
        description = "最帥的同學收",
        client = {}
    },
    ["c123-1"] = {
        label = " ",
         -- '眼珠',
        weight = 10,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            usetime = 800,
            notification = ""
        }
    },
    ["c124-1"] = {
        label = " ",
         -- '荼蘼',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        description = "荼蘼",
        client = {}
    },
    ["c125-1"] = {
        label = " ",
         -- '鳶尾',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        description = "鳶尾",
        client = {}
    },
    ["c126-1"] = {
        label = " ",
         -- '空鳳',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        description = "空鳳",
        client = {}
    },
    ["c127-1"] = {
        label = " ",
         -- '青椒',
        weight = 100,
        stack = true,
        close = true,
        consume = 1,
        description = "青椒",
        client = {}
    },
    ["c128-1"] = {
        label = " ",
         -- '荔枝',
        weight = 30,
        stack = true,
        close = true,
        consume = 1,
        description = "荔枝",
        client = {}
    },
    ["c129-1"] = {
        label = " ",
         -- '茶葉',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        description = "茶葉",
        client = {}
    },
    ["c130-1"] = {
        label = " ",
         --'芹菜',
        weight = 30,
        stack = true,
        close = true,
        consume = 0,
        description = "芹菜"
    },
    ["c131-1"] = {
        label = " ",
         --'苦瓜',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        description = "苦瓜"
    },
    ["c18-2"] = {
        label = " ",
         -- '璟湘花',
        weight = 20,
        stack = true,
        close = true,
        consume = 0,
        description = "璟湘花",
        client = {}
    },
    ["c132-1"] = {
        label = " ",
         -- '水晶蘭',
        weight = 20,
        stack = true,
        close = true,
        consume = 0,
        description = "水晶蘭",
        client = {}
    },
    ["c133-1"] = {
        label = " ",
         -- '白色水仙花',
        weight = 20,
        stack = true,
        close = true,
        consume = 0,
        description = "白色水仙花",
        client = {}
    },
    ["c134-1"] = {
        label = " ",
         -- '阿里山龍膽',
        weight = 20,
        stack = true,
        close = true,
        consume = 0,
        description = "阿里山龍膽",
        client = {}
    },
    ["c135-1"] = {
        label = " ",
         -- '星辰花',
        weight = 20,
        stack = true,
        close = true,
        consume = 0,
        description = "星辰花",
        client = {}
    },
    ["c136-1"] = {
        label = " ",
         -- '洋甘菊',
        weight = 20,
        stack = true,
        close = true,
        consume = 0,
        description = "洋甘菊",
        client = {}
    },
    ["c137-1"] = {
        label = " ",
         -- '蒲公英',
        weight = 20,
        stack = true,
        close = true,
        consume = 0,
        description = "蒲公英",
        client = {}
    },
    ["c138-1"] = {
        label = " ",
         -- '葡萄柚',
        weight = 150,
        stack = true,
        close = true,
        consume = 1,
        description = "葡萄柚",
        client = {
            status = {thirst = 100000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 1500,
            notification = ""
        }
    },
    ["c139-1"] = {
        label = " ",
         -- '花生',
        weight = 50,
        stack = true,
        close = true,
        consume = 1,
        description = "花生",
        client = {}
    },
    ["c140-1"] = {
        label = " ",
         -- '水蓮',
        weight = 50,
        stack = true,
        close = true,
        consume = 1,
        description = "水蓮",
        client = {}
    },
    ["c190-1"] = {
        label = " ",
         -- '大腦',
        weight = 235,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["c94-1"] = {
        label = " ",
         -- '藥草',
        weight = 10,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["c7-2"] = {
        label = " ",
         -- '水',
        weight = 350,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {thirst = 600000},
            anim = "drinking",
            prop = "bottle",
            usetime = 1500,
            notification = ""
        }
    },
    ["c96-1"] = {
        label = " ",
         -- '蔬菜',
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
    ["c97-1"] = {
        label = " ",
         -- '水果',
        weight = 450,
        stack = false,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {hunger = 50000, thirst = 100000},
            anim = "eating",
            prop = "burger",
            usetime = 1500,
            notification = ""
        }
    },
    ["c98-1"] = {
        label = " ",
         -- '動物肉',
        weight = 350,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {hunger = 150000},
            anim = "eating",
            prop = "burger",
            usetime = 1500,
            notification = ""
        }
    },
    ["c99-1"] = {
        label = " ",
         -- '人肉',
        weight = 350,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {hunger = 150000},
            anim = "eating",
            prop = "burger",
            usetime = 1500,
            notification = ""
        }
    },
    ["c100-1"] = {
        label = " ",
         -- '海鮮',
        weight = 450,
        stack = false,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {hunger = 250000, thirst = 100000},
            anim = "eating",
            prop = "burger",
            usetime = 1500,
            notification = ""
        }
    },
    ["c183-2"] = {
        label = " ",
         -- '蛋',
        weight = 50,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {hunger = 50000},
            anim = "eating",
            prop = "burger",
            usetime = 1500,
            notification = ""
        }
    },
    ["c102-1"] = {
        label = " ",
         -- '穀物',
        weight = 350,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {hunger = 50000},
            anim = "eating",
            prop = "burger",
            usetime = 1500,
            notification = ""
        }
    },
    ["c103-1"] = {
        label = " ",
         -- '髒水',
        weight = 650,
        stack = false,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {thirst = 100000},
            anim = "drinking",
            prop = "bottle",
            usetime = 3500,
            notification = ""
        }
    },
    ["c109-1"] = {
        label = " ",
         -- '鳳梨種子',
        weight = 10,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["c110-1"] = {
        label = " ",
         -- '蘋果種子',
        weight = 10,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["c111-1"] = {
        label = " ",
         -- '橘子種子',
        weight = 10,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["c112-1"] = {
        label = " ",
         -- '草莓種子',
        weight = 10,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["c114-1"] = {
        label = " ",
         -- '南瓜',
        weight = 350,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["c115-1"] = {
        label = " ",
         -- '地瓜葉',
        weight = 100,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["c116-1"] = {
        label = " ",
         -- '豆芽',
        weight = 100,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["c117-1"] = {
        label = " ",
         -- '樹葉',
        weight = 100,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["c118-1"] = {
        label = " ",
         -- '獨角仙幼蟲',
        weight = 30,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {hunger = 30000, thirst = 50000},
            anim = "eating",
            prop = "burger",
            usetime = 1500,
            notification = "汁很多有點解渴。"
        }
    },
    ["c119-1"] = {
        label = " ",
         -- '南瓜種子',
        weight = 5,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {}
    },
    ["c120-1"] = {
        label = " ",
         -- '高麗菜種子',
        weight = 5,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {}
    },
    ["c95-1"] = {
        label = " ",
         -- '玉米種子',
        weight = 5,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {}
    },
    ["c94-2"] = {
        label = " ",
         --'藥草',
        weight = 20,
        stack = true,
        close = true,
        consume = 1,
        client = {
            status = {},
            anim = "eating",
            prop = "burger",
            usetime = 1000,
            notification = ""
        }
    },
    ["c185-1"] = {
        label = " ",
         -- '冬瓜',
        weight = 300,
        stack = false,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {hunger = 50000, thirst = 50000},
            anim = "eating",
            prop = "burger",
            usetime = 1000,
            notification = ""
        }
    },
    ["c95-2"] = {
        label = " ",
         -- '玉米種子',
        weight = 15,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["c121-1"] = {
        label = " ",
         -- '橘子',
        weight = 100,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {hunger = 50000, thirst = 50000},
            anim = "eating",
            prop = "burger",
            usetime = 1000,
            notification = ""
        }
    },
    ["c122-1"] = {
        label = " ",
         -- '一般化石',
        weight = 1200,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["c141-1"] = {
        label = " ",
         -- '芋頭',
        weight = 200,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {hunger = 150000},
            anim = "eating",
            usetime = 1500,
            notification = ""
        }
    },
    ["c141-2"] = {
        label = " ",
         -- '芋頭',
        weight = 200,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {hunger = 150000},
            anim = "eating",
            usetime = 1500,
            notification = ""
        }
    },
    ["c141-3"] = {
        label = " ",
         -- '芋頭',
        weight = 200,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {hunger = 150000},
            anim = "eating",
            usetime = 1500,
            notification = ""
        }
    },
    ["c141-4"] = {
        label = " ",
         -- '芋頭',
        weight = 0,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {hunger = 150000},
            anim = "eating",
            usetime = 1500,
            notification = ""
        }
    },
    ["c141-5"] = {
        label = " ",
         -- '芋頭',
        weight = 0,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {hunger = 150000},
            anim = "eating",
            usetime = 1500,
            notification = ""
        }
    },
    ["c146-1"] = {
        label = " ",
         --'肉',
        weight = 100,
        stack = true,
        close = true,
        description = "肉",
        consume = 1,
        client = {
            status = {hunger = 45000, thirst = 0, drunk = 0},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            prop = {
                model = "prop_cs_burger_01",
                pos = {x = 0.02, y = 0.02, z = -0.02},
                rot = {x = 0.0, y = 0.0, z = 0.0}
            },
            usetime = 2500
        }
    },
    ["c104-1"] = {
        label = " ",
         -- '斷肢1',
        weight = 50,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["c104-2"] = {
        label = " ",
         -- '斷肢2',
        weight = 100,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["c104-3"] = {
        label = " ",
         -- '斷肢3',
        weight = 350,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["c104-4"] = {
        label = " ",
         -- '斷肢4',
        weight = 450,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["c104-5"] = {
        label = " ",
         -- '斷肢5',
        weight = 350,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ['c79-1'] = {
		label = ' ',--'原油',

      weight = 80,
      stack = true,
      close = true,
    },
}
