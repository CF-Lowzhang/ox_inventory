return {
    ["t1-1"] = {
        label = " ",
         --'釣竿',
        weight = 500,
        stack = 1,
        close = 1,
        consume = 0,
        client = {
            event = "fishing:fishstart"
        }
    },
    ["t1-2"] = {
        label = " ",
         --'採集斧頭',
        weight = 250,
        stack = true,
        close = true,
        description = "採集斧頭",
        client = {
            event = "WhalEpic_General:hacha_dig"
        }
    },
    ["t1-3"] = {
        label = " ",
         --'採集鎬子',
        weight = 250,
        stack = true,
        close = true,
        description = "採集鎬子",
        client = {
            event = "WhalEpic_General:pickaxe"
        }
    },
    ["t1-4"] = {
        label = " ",
         --'採集鏟子',
        weight = 250,
        stack = true,
        close = true,
        consume = 0,
        description = "採集鏟子",
        client = {
            event = "esx_digitem:toggle"
        }
    },
    ["t1-5"] = {
        label = " ",
         --'採集鐮刀',
        weight = 250,
        stack = true,
        close = true,
        description = "採集鐮刀",
        client = {
            event = "WhalEpic_General:sickle_dig"
        }
    },
    ["t2-1"] = {
        label = " ",
         --'裝甲(厚)',
        weight = 2000,
        stack = 1,
        close = 1,
        description = "",
        client = {
            usetime = 2500
        }
    },
    ["t2-2"] = {
        label = " ",
         --'裝甲(輕)',
        weight = 1000,
        stack = 1,
        close = 1,
        description = "",
        client = {
            usetime = 2500
        }
    },
    ["t3-1"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t3-2"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t3-3"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t4-1"] = {
        label = "繃帶",         --'繃帶',
        weight = 10,
        consume = 1,
        client = {
            anim = {dict = "missheistdockssetup1clipboard@idle_a", clip = "idle_a", flag = 49},
            disable = {move = true, car = true, combat = true},
            usetime = 2500
        }
    },
    ["t4-2"] = {
        label = "外傷繃帶",         --'外傷繃帶',
        weight = 10,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            anim = {dict = "missheistdockssetup1clipboard@idle_a", clip = "idle_a", flag = 49},
            prop = {model = "prop_rolled_sock_02", pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0)},
            disable = {move = true, car = true, combat = true},
            usetime = 2500
        }
    },
    ["t4-3"] = {
        label = "繃繃蹦",         --'繃繃蹦',
        weight = 50,
        stack = 1,
        close = 1,
        description = "",
        client = {
            anim = {dict = "missheistdockssetup1clipboard@idle_a", clip = "idle_a", flag = 49},
            prop = {model = "prop_rolled_sock_02", pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0)},
            disable = {move = true, car = true, combat = true},
            usetime = 5000
        }
    },
    ["t4-4"] = {
        label = "繃帶",         -- '繃帶',
        weight = 50,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            anim = {dict = "missheistdockssetup1clipboard@idle_a", clip = "idle_a", flag = 49},
            disable = {move = true, car = true, combat = true},
            usetime = 2500
        }
    },
    ["t5-1"] = {
        label = " ",
         --'bowlingball',
        weight = 0,
        stack = 1,
        close = 1,
        description = ""
    },
    ["t5-2"] = {
        label = " ",
         --'籃球',
        weight = 0,
        stack = true,
        close = true,
        consume = 1,
        client = {
            usetime = 0
            --'wf_menuViewer:item'
        }
    },
    ["t6-1"] = {
        label = " ",
         --'魚餌',
        weight = 5,
        stack = 1,
        close = 0,
        description = "魚餌",
        client = {
            usetime = 500
        }
    },
    ["t7-1"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t9-1"] = {
        label = "打火機", --'打火機',
        weight = 50,
        stack = true,
        close = true,
        consume = 0,
        description = "打火機"
    },
    ["t9-2"] = {
        label = "打火機",    -- 'US國品牌的打火機',
        weight = 60,
        stack = true,
        close = true,
        consume = 0,
        description = "美國牌打火機",
        client = {}
    },
    ["t9-3"] = {
        label = "打火機",    -- '打火機',
        weight = 100,
        stack = true,
        close = true,
        consume = 0,
        description = "打火機",
        client = {}
    },
    ["t9-4"] = {
        label = "打火機",    -- '打火機',
        weight = 70,
        stack = true,
        close = true,
        consume = 0,
        description = "打火機",
        client = {}
    },
    ["t10-1"] = {
        label = " ",
         --'解鎖用具',
        weight = 300,
        stack = 1,
        close = 1,
        description = ""
    },
    ["t11-1"] = {
        label = " ",
         --'修眉刀',
        weight = 100,
        stack = 1,
        close = 0,
        description = ""
    },
    ["t12-1"] = {
        label = " ",
         --'鑽頭',
        weight = 500,
        stack = 1,
        close = 1,
        description = ""
    },
    ["t13-1"] = {
        label = " ",
         --'修理包(一次性)',
        weight = 100,
        stack = 1,
        close = 1,
        consume = 1,
        description = "",
        client = {
            usetime = 2500
        }
    },
    ["t13-2"] = {
        label = " ",
         --'維修工具',
        weight = 100,
        stack = 1,
        close = 1,
        description = ""
    },
    ["t14-1"] = {
        label = " ",
         --'紗布',
        weight = 15,
        stack = 1,
        close = 1,
        description = "",
        client = {
            anim = {dict = "missheistdockssetup1clipboard@idle_a", clip = "idle_a", flag = 49},
            disable = {move = true, car = true, combat = true},
            usetime = 2500
        }
    },
    ["t15-1"] = {
        label = " ",
         --'塗鴉噴灌',
        weight = 23,
        stack = 1,
        close = 1,
        description = "",
        client = {
            status = {hunger = 5000},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp"},
            usetime = 2500
        }
    },
    ["t16-1"] = {
        label = " ",
         --'開礦火藥',
        weight = 250,
        stack = 1,
        close = 1,
        description = "小範圍爆炸，可以有效炸掉比較脆弱、沒用的土壤，讓礦石裸露出來，增加挖礦效率"
    },
    ["t17-1"] = {
        label = " ",
         --'吉他',
        weight = 350,
        stack = 1,
        close = 1,
        description = ""
    },
    ["t18-1"] = {
        label = " ",
         --'隨身音箱',
        weight = 250,
        stack = 1,
        close = 1,
        description = "",
        client = {
            usetime = 0
            --'wf_menuViewer:item'
        }
    },
    ["t19-1"] = {
        label = "冰敷袋",       --'冰敷袋',
        weight = 20,
        stack = 1,
        close = 1,
        description = "",
        client = {
            usetime = 2500
        }
    },
    ["t20-1"] = {
        label = " ",
         --'望遠鏡',
        weight = 125,
        stack = 0,
        close = 1,
        consume = 0,
        description = "望遠鏡",
        client = {
            usetime = 0
        }
    },
    ["t20-2"] = {
        label = " ",
         --'多功能望遠鏡',
        weight = 222,
        stack = 1,
        close = 1,
        consume = 0,
        description = "",
        client = {
            usetime = 0
        }
    },
    ["t21-1"] = {
        label = "拐杖",     --'拐杖',
        weight = 444,
        stack = 1,
        close = 1,
        description = "",
        client = {
            event = "r4lle_krycka:UseKrycka"
        }
    },
    ["t22-1"] = {
        label = "筆記本",
         --'筆記本',
        weight = 75,
        stack = 1,
        close = 1,
        description = "筆記本",
        consume = 0,
        client = {
            usetime = 0
        }
    },
    ["t22-2"] = {
        label = " ",
         --'筆記本',
        weight = 5,
        stack = 1,
        close = 1,
        description = "很特別的筆記本",
        consume = 0,
        client = {
            event = "WhalEpic_General:SpecialNotes"
        }
    },
    ["t23-1"] = {
        label = " ",
         --'寵物包包',
        weight = 4500,
        stack = 1,
        close = 1,
        description = ""
    },
    ["t24-1"] = {
        label = " ",
         --'潛水裝備',
        weight = 500,
        stack = 1,
        close = 1,
        consume = 0,
        description = "潛水裝備",
        client = {
            usetime = 2500
        }
    },
    ["t26-1"] = {
        label = " ",
         --'無線電',
        weight = 100,
        stack = 1,
        close = 0,
        description = "無線電",
        client = {
            event = "we_radio:openRadio",
            remove = function(total)
                if total < 1 then
                    print(total)
                    TriggerEvent("we_radio:disableRadio")
                end
            end
        }
    },
    ["t27-1"] = {
        label = " ",
         --'剃須刀',
        weight = 100,
        stack = 1,
        close = 0,
        description = ""
    },
    ["t28-1"] = {
        label = " ",
         --'鎮暴盾牌',
        weight = 2500,
        stack = 1,
        close = 1,
        description = "",
        client = {
            event = "shield:toggle_shield"
        }
    },
    ["t29-1"] = {
        label = "滑板",     --'滑板',
        weight = 500,
        stack = false,
        close = 1,
        consume = 0,
        description = "看起來壞掉了，無法使用。",
        client = {
            event = "longboard:spawn"
        }
    },
    ["t29-2"] = {
        label = "滑板",      -- '滑板',
        weight = 800,
        stack = false,
        close = true,
        consume = 0,
        description = "看起來壞掉了，無法使用。",
        client = {
            usetime = 500,
            event = "longboard:spawn"
        }
    },
    ["t30-1"] = {
        label = "音響",      --'音響',
        weight = 600,
        stack = 1,
        consume = 0,
        close = 1,
        clinet = {}
    },
    ["t31-1"] = {
        label = " ",
         --'抹布',
        weight = 100,
        stack = 1,
        close = 1,
        description = ""
    },
    ["t32-1"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t32-1"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t32-2"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t33-1"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t33-2"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t33-3"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t34-1"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t34-1"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t34-2"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t36-1"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t37-1"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t37-2"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t38-1"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t39-1"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t39-2"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t39-3"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t39-4"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t39-5"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t40-1"] = {
        label = " ",
         --'荊棘草',
        weight = 100,
        stack = true,
        close = true
    },
    ["t40-2"] = {
        label = " ",
         --'氮氣加速(車子)',
        weight = 150,
        stack = true,
        close = true,
        consume = 1,
        client = {
            usetime = 0
        }
    },
    ["t43-1"] = {
        label = " ",
         --'Parachute',
        weight = 8000,
        stack = false,
        client = {
            anim = {dict = "clothingshirt", clip = "try_shirt_positive_d"},
            usetime = 1500
        }
    },
    ["t44-1"] = {
        label = " ",
         --'Knickers',
        weight = 10,
        consume = 0,
        client = {
            status = {thirst = -100000, stress = -25000},
            anim = {dict = "mp_player_intdrink", clip = "loop_bottle"},
            prop = {model = "prop_cs_panties_02", pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5)},
            usetime = 2500
        }
    },
    ["t45-1"] = {
        label = " ",
         --'木框眼鏡',
        weight = 50,
        stack = true,
        close = true
    },
    ["t45-2"] = {
        label = " ",
         --'矯正眼鏡',
        weight = 110,
        stack = true,
        close = true,
        consume = 0,
        description = "看起來是一副很特殊的眼鏡",
        client = {
            usetime = 0
        }
    },
    ["t46-1"] = {
        label = " ",
         --'書',
        weight = 100,
        stack = true,
        close = true,
        client = {}
    },
    ["t46-2"] = {
        label = " ",
         --'小黃書',
        weight = 100,
        stack = 1,
        close = 0,
        description = ""
    },
    ["t47-1"] = {
        label = " ",
         --'信封',
        weight = 1,
        stack = false,
        close = false,
        consume = 0
    },
    ["t47-2"] = {
        label = " ",
         --'黑信封(5格)',
        weight = 1,
        stack = false,
        close = false,
        consume = 0
    },
    ["t47-3"] = {
        label = " ",
         --'白信封(5格)',
        weight = 1,
        stack = false,
        close = false,
        consume = 0
    },
    ["t48-1"] = {
        label = " ",
         -- '水槍拉 幹',
        weight = 3000,
        stack = false,
        close = true,
        consume = 0,
        description = "玩具槍，不會死。",
        client = {
            event = "devcore_watergun:c_Start"
        }
    },
    ["t49-1"] = {
        label = " ",
         -- '叉子',
        weight = 170,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {}
    },
    ["t49-2"] = {
        label = " ",
         --'竹籤',
        weight = 50,
        stack = true,
        close = true,
        consume = 0,
        description = "竹籤",
        client = {}
    },
    ["t50-1"] = {
        label = " ",
         --'肥料',
        weight = 600,
        stack = true,
        close = true,
        consume = 0,
        description = "肥料",
        client = {
            event = "WhalEpic_General:fatting"
        }
    },
    ["t51-1"] = {
        label = " ",
         --'樹苗',
        weight = 400,
        stack = true,
        close = true,
        consume = 0,
        description = "樹苗",
        client = {}
    },
    ["t52-1"] = {
        label = " ",
         --'魚苗',
        weight = 8,
        stack = true,
        close = true,
        consume = 0,
        description = "魚苗",
        client = {
            usetime = 0
        }
    },
    ["t53-1"] = {
        label = " ",
         --'項鍊',
        weight = 70,
        stack = true,
        close = true,
        consume = 0,
        description = "乳白色且透光的十字架項鍊",
        client = {}
    },
    ["t53-2"] = {
        label = " ",
         --'鯊魚牙項鍊',
        weight = 100,
        stack = 1,
        close = 0,
        description = ""
    },
    ["t53-3"] = {
        label = " ",
         --'琥珀項鍊',
        weight = 250,
        stack = true,
        close = true,
        client = {
            usetime = 0
        }
    },
    ["t53-4"] = {
        label = " ",
         --'白玫瑰鍊墜',
        weight = 12,
        stack = true,
        close = true
    },
    ["t53-5"] = {
        label = " ",
         --'鑽石項鍊',
        weight = 77,
        stack = true,
        close = true
    },
    ["t54-1"] = {
        label = " ",
         --'配方表',
        weight = 10,
        stack = 1,
        description = "",
        consume = 1,
        client = {
            usetime = 2500
        }
    },
    ["t54-2"] = {
        label = " ",
         --'空白配方表',
        weight = 10,
        stack = 1,
        description = "空白配方表",
        consume = 1,
        client = {
            usetime = 2500
        }
    },
    ["t55-1"] = {
        label = " ",
         --'木梳',
        weight = 25,
        stack = true,
        close = true,
        description = "木梳"
    },
    ["t56-1"] = {
        label = " ",
         --'便當盒',
        weight = 25,
        stack = true,
        close = true
    },
    ["t56-2"] = {
        label = " ",
         --'便當盒',
        weight = 200,
        stack = true,
        close = true,
        description = "便當盒"
    },
    ["t56-3"] = {
        label = " ",
         --'髒便當盒',
        weight = 200,
        stack = true,
        close = true,
        description = "髒掉的便當盒"
    },
    ["t57-1"] = {
        label = " ",
         --'大玻璃瓶',
        weight = 25,
        stack = true,
        close = true,
        description = "大玻璃瓶"
    },
    ["t57-2"] = {
        label = " ",
         --'玻璃瓶',
        weight = 20,
        stack = true,
        close = true
    },
    ["t58-1"] = {
        label = "Caster五毫克",     --'Caster五毫克',
        weight = 54,
        stack = true,
        close = true,
        description = "Caster五毫克",
        consume = 1,
        client = {
            usetime = 2500
        }
    },
    ["t58-2"] = {
        label = "Mild Seven",      --'Mild Seven',
        weight = 54,
        stack = true,
        close = true,
        consume = 1,
        description = "Mild Seven",
        client = {
            usetime = 2500
        }
    },
    ["t58-3"] = {
        label = "萬寶路Dry",   --'萬寶路Dry',
        weight = 54,
        stack = true,
        close = true,
        consume = 1,
        description = "萬寶路Dry",
        client = {
            usetime = 2500
        }
    },
    ["t59-1"] = {
        label = " ",
         --'遙控車',
        weight = 882,
        stack = false,
        close = 1,
        consume = 0,
        description = "",
        client = {}
    },
    ["t60-1"] = {
        label = " ",
         --'家傳廚刀',
        weight = 300,
        stack = 1,
        description = "",
        consume = 1,
        client = {
            usetime = 2500
        }
    },
    ["t60-2"] = {
        label = " ",
         --'家傳廚刀',
        weight = 300,
        stack = 1,
        description = "",
        consume = 1,
        client = {
            usetime = 2500
        }
    },
    ["t60-3"] = {
        label = " ",
         --'阿基刀',
        weight = 200,
        stack = true,
        close = true
    },
    ["t61-1"] = {
        label = " ",
         --'紅色麻繩',
        weight = 100,
        stack = 0,
        close = 0,
        consume = 0,
        description = "",
        client = {}
    },
    ["t62-1"] = {
        label = " ",
         --'馬鞭',
        weight = 100,
        stack = 0,
        close = 0,
        description = ""
    },
    ["t64-1"] = {
        label = " ",
         --'眼罩',
        weight = 20,
        stack = false,
        close = true,
        description = "可以戴上。",
        consume = 0,
        client = {
            usetime = 2500
        }
    },
    ["t65-1"] = {
        label = " ",
         --'簡易開鎖用具',
        weight = 20,
        stack = true,
        close = true,
        client = {
            usetime = 6000
        }
    },
    ["t65-2"] = {
        label = " ",
         --'開鎖器',
        weight = 160,
        stack = true,
        close = true,
        client = {
            anim = {dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", clip = "machinic_loop_mechandplayer"},
            disable = {move = true, car = true, combat = true},
            usetime = 5000,
            cancel = true
        }
    },
    ["t66-1"] = {
        label = " ",
         --'生命體探測器',
        weight = 10,
        stack = true,
        close = true,
        consume = 1,
        client = {
            event = "WhalEpic_General:Radar"
        }
    },
    ["t67-1"] = {
        label = " ",
         --'針筒(麻醉)',
        weight = 50,
        stack = true,
        close = true,
        client = {
            usetime = 0
            -- 'wf_menuViewer:item'
        }
    },
    ["t68-1"] = {
        label = " ",
         --'瓶子',
        weight = 20,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t69-1"] = {
        label = " ",
         --'鯨魚耳環',
        weight = 112,
        stack = true,
        close = true,
        description = "一對高級的海藍璃石貝耳環，刻著  Patrino infano amo."
    },
    ["t70-2"] = {
        label = " ",
         --'改車包(藍圖)',
        weight = 1,
        stack = true,
        close = true
    },
    ["t70-2"] = {
        label = " ",
         --'改車包',
        weight = 250,
        stack = true,
        close = true
    },
    ["t71-1"] = {
        label = " ",
         --'火種',
        weight = 45,
        stack = true,
        close = true
    },
    ["t72-1"] = {
        label = " ",
         --'固定器材',
        weight = 600,
        stack = true,
        close = true
    },
    ["t73-1"] = {
        label = " ",
         --'萬能鑰匙',
        weight = 4,
        stack = true,
        close = true
    },
    ["t74-1"] = {
        label = " ",
         --'攝影套組',
        weight = 1500,
        stack = true,
        close = true,
        description = "攝影套組"
    },
    ["t75-1"] = {
        label = " ",
         --'黃金戒指',
        weight = 80,
        stack = true,
        close = true
    },
    ["t76-1"] = {
        label = " ",
         --'載具材料(藍圖)',
        weight = 1,
        stack = true,
        close = true
    },
    ["t76-2"] = {
        label = " ",
         --'載具材料',
        weight = 400,
        stack = true,
        close = true
    },
    ["t77-1"] = {
        label = " ",
         --'手機',
        weight = 190,
        stack = false,
        close = true,
        consume = 0,
        description = "壞了",
        client = {
            usetime = 0
        }
    },
    ["t78-1"] = {
        label = " ",
         --'學生證',
        weight = 0,
        stack = true,
        close = true,
        consume = 0,
        client = {
            usetime = 0
        }
    },
    ["t79-1"] = {
        label = " ",
         --'小袋子(10格)',
        weight = 1,
        stack = false,
        close = false,
        consume = 0
    },
    ["t79-2"] = {
        label = " ",
         --'小袋子(5格)',
        weight = 1,
        stack = false,
        close = false,
        consume = 0
    },
    ["t79-3"] = {
        label = " ",
         --'狗狗紙袋',
        weight = 20,
        stack = true,
        close = true
    },
    ["t80-1"] = {
        label = " ",
         --'玉蘭花香包',
        weight = 65,
        stack = true,
        close = true
    },
    ["t81-1"] = {
        label = "毛巾",     --'毛巾',
        weight = 200,
        stack = true,
        close = true,
        client = {
        }
    },
    ["t81-2"] = {
        label = "熱毛巾",      --'熱毛巾',
        weight = 250,
        stack = true,
        close = true,
        client = {
        }
    },
    ["t81-3"] = {
        label = "髒毛巾",      --'髒毛巾',
        weight = 200,
        stack = true,
        close = true
    },
    ["t82-1"] = {
        label = " ",
         --'健身啞鈴',
        weight = 15000,
        stack = true,
        close = true
    },
    ["t83-1"] = {
        label = " ",
         --'矽石鏟',
        weight = 450,
        stack = true,
        close = true
    },
    ["t84-1"] = {
        label = " ",
         --'寵物罐頭',
        weight = 100,
        stack = true,
        close = true,
        description = "寵物罐頭",
        client = {
            status = {hunger = 100000},
            anim = "eating",
            prop = "burger",
            usetime = 1000,
            notification = "食之無味"
        }
    },
    ["t84-2"] = {
        label = " ",
         --'貓草',
        weight = 4,
        stack = true,
        close = true
    },
    ["t84-3"] = {
        label = " ",
         -- '貓罐頭',
        weight = 150,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            status = {hunger = 100000},
            anim = "eating",
            prop = "burger",
            usetime = 1000
        }
    },
    ["t85-1"] = {
        label = " ",
         --'藍紫羅蘭花束',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        client = {}
    },
    ["t85-2"] = {
        label = " ",
         --'鈴蘭花花束',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        client = {}
    },
    ["t85-3"] = {
        label = " ",
         --'棉花花束',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        client = {}
    },
    ["t85-4"] = {
        label = " ",
         --'紫羅蘭花束',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        client = {}
    },
    ["t85-5"] = {
        label = " ",
         --'玫瑰鈴蘭花束',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        client = {}
    },
    ["t85-6"] = {
        label = " ",
         --'玫瑰棉花花束',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        client = {}
    },
    ["t85-7"] = {
        label = " ",
         --'粉玫瑰百合花束',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        client = {}
    },
    ["t85-8"] = {
        label = " ",
         --'粉玫瑰紫羅蘭花束',
        weight = 150,
        stack = true,
        close = true,
        description = "",
        consume = 0,
        client = {}
    },
    ["t85-9"] = {
        label = " ",
         --'花束',
        weight = 0,
        stack = true,
        close = true,
        client = {
            usetime = 0
            --'wf_menuViewer:item'
        }
    },
    ["t86-1"] = {
        label = " ",
         -- '說話的藝術',
        weight = 700,
        stack = true,
        close = true,
        consume = 0,
        description = "文字書的封條上寫著：「說話讓人舒服的程度，決定你的高度，還在為說不好話造成的誤會和煩惱嗎？讓說話的藝術拯救你有口難言的困境吧！」",
        client = {}
    },
    ["t87-1"] = {
        label = " ",
         --'防水加厚棉紙',
        weight = 50,
        stack = true,
        close = true,
        description = "防水加厚棉紙"
    },
    ["t87-2"] = {
        label = " ",
         --'防水加厚棉歐亞紙',
        weight = 50,
        stack = true,
        close = true,
        description = "防水加厚棉歐亞紙"
    },
    ["t87-3"] = {
        label = " ",
         --'緞帶',
        weight = 50,
        stack = true,
        close = true,
        description = "緞帶"
    },
    ["t88-1"] = {
        label = " ",
         --'銀紙',
        weight = 15,
        stack = true,
        close = true,
        description = "銀紙",
        consume = 1,
        client = {
            notification = "感到微微的安心。"
        }
    },
    ["t88-2"] = {
        label = " ",
         --'金紙',
        weight = 15,
        stack = true,
        close = true,
        description = "金紙",
        consume = 1,
        client = {
            notification = "感到微微的安心。"
        }
    },
    ["t88-3"] = {
        label = " ",
         --'線香',
        weight = 10,
        stack = true,
        close = true,
        description = "線香",
        consume = 1,
        client = {
            notification = "感到微微的安心。"
        }
    },
    ["t89-1"] = {
        label = " ",
         -- '口紅',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t89-2"] = {
        label = " ",
         -- '口紅',
        weight = 50,
        stack = true,
        close = true,
        consume = 0,
        description = "帶有香甜的焦糖味",
        client = {}
    },
    ["t90-1"] = {
        label = " ",
         -- '警刀',
        weight = 143,
        stack = false,
        close = true,
        consume = 0,
        description = "【希塔分局-王碩彥】",
        client = {
            usetime = 500
        }
    },
    ["t90-2"] = {
        label = " ",
         -- '警刀',
        weight = 143,
        stack = false,
        close = true,
        consume = 0,
        description = "【希塔分局-東雲悠里】",
        client = {
            usetime = 500
        }
    },
    ["t91-1"] = {
        label = " ",
         -- '隨身聽',
        weight = 700,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t91-2"] = {
        label = " ",
         -- '隨身聽',
        weight = 150,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {
            usetime = 500
        }
    },
    ["t92-1"] = {
        label = " ",
         -- '撲克',
        weight = 90,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t92-2"] = {
        label = " ",
         -- '撲克',
        weight = 350,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t93-1"] = {
        label = "鑰匙包",
         -- '包包',
        weight = 1,
        stack = false,
        close = false,
        consume = 0,
    },
    ["t93-2"] = {
        label = " ",
         -- '包包含衣服',
        weight = 35,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t94-1"] = {
        label = " ",
         -- '',
        weight = 20,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t95-1"] = {
        label = " ",
         -- '髒針頭',
        weight = 20,
        stack = false,
        close = true,
        consume = 0,
        description = "有使用過的痕跡",
        client = {}
    },
    ["t96-1"] = {
        label = " ",
         -- '縫合針',
        weight = 5,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t97-1"] = {
        label = " ",
         -- '鑷子',
        weight = 30,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t98-1"] = {
        label = " ",
         -- '持針器',
        weight = 50,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t99-1"] = {
        label = " ",
         -- '手術刀',
        weight = 10,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t100-1"] = {
        label = " ",
         -- '開罐器',
        weight = 350,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t101-1"] = {
        label = " ",
         -- '火柴',
        weight = 50,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t102-1"] = {
        label = " ",
         -- '汽油桶',
        weight = 1000,
        stack = false,
        close = true,
        consume = 1,
        description = "",
        client = {}
    },
    ["t103-1"] = {
        label = " ",
         -- '工具箱',
        weight = 900,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t104-1"] = {
        label = " ",
         -- '板手',
        weight = 250,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t105-1"] = {
        label = " ",
         -- '螺絲起子',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t106-1"] = {
        label = " ",
         -- '十字板手',
        weight = 250,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t107-1"] = {
        label = " ",
         -- '空瓶',
        weight = 20,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t108-1"] = {
        label = " ",
        weight = 20,
        stack = true,
        close = true,
        consume = 0.05,
        description = "",
        client = {
            usetime = 500
        }
    },
    ["t109-1"] = {
        label = "保險套",      -- '保險套',
        weight = 10,
        stack = true,
        close = true,
        consume = 1,
        client = {
            usetime = 3500
        }
    },
    ["t110-1"] = {
        label = " ",
         -- '時尚雜誌',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {
            usetime = 500
        }
    },
    ["t111-1"] = {
        label = "漫畫",       -- '漫畫',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {
            usetime = 500
        }
    },
    ["t112-1"] = {
        label = " ",
         -- '世界經典書籍',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {
            usetime = 500
        }
    },
    ["t113-1"] = {
        label = " ",
         -- '聊齋',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {
            usetime = 500
        }
    },
    ["t114-1"] = {
        label = " ",
         -- '成人雜誌',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {
            usetime = 500
        }
    },
    ["t115-1"] = {
        label = " ",
         -- '蠟筆',
        weight = 50,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t116-1"] = {
        label = "牙刷",     -- '牙刷',
        weight = 10,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t117-1"] = {
        label = "牙膏",      -- '牙膏',
        weight = 150,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t118-1"] = {
        label = " ",
         -- '皮帶',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t119-1"] = {
        label = " ",
         -- '耳機',
        weight = 10,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t120-1"] = {
        label = " ",
         -- '刮鬍刀',
        weight = 10,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t121-1"] = {
        label = " ",
         -- '梳子',
        weight = 50,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t122-1"] = {
        label = " ",
         -- '軟木塞',
        weight = 5,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t123-1"] = {
        label = " ",
         -- '開瓶器',
        weight = 150,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t124-1"] = {
        label = " ",
         -- '一公升軍用水壺',
        weight = 1000,
        stack = false,
        close = true,
        consume = 0.25,
        description = "",
        client = {
            status = {thirst = 50000},
            anim = "drinking",
            prop = "bottle",
            usetime = 1500,
            remove = function(total)
                if total < 1 then
                    lib.notify({description = "你的水壺空了!"})
                    ExecuteCommand("helpme_giveitem g1_3931_can1 1")
                end
            end
        }
    },
    ["t125-1"] = {
        label = " ",
         -- '一公升軍用水壺(空)',
        weight = 15,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t126-1"] = {
        label = " ",
         -- '美樂蒂裁縫包',
        weight = 100,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t127-1"] = {
        label = "法蘭絨單人毛毯",         -- '美樂蒂裁縫包',
        weight = 200,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t128-1"] = {
        label = " ",
         -- 'US國品牌香菸盒',
        weight = 350,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t129-1"] = {
        label = " ",
         -- '小刀',
        weight = 413,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t130-1"] = {
        label = " ",
         -- '相機',
        weight = 1450,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t131-1"] = {
        label = " ",
         -- '武士刀',
        weight = 2500,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {
            usetime = 500
        }
    },
    ["t132-1"] = {
        label = " ",
         -- '匕首,
        weight = 125,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {
            usetime = 500
        }
    },
    ["t133-1"] = {
        label = " ",
         -- '髮圈',
        weight = 10,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {
            usetime = 500
        }
    },
    ["t134-1"] = {
        label = " ",
         -- '黑石香菸',
        weight = 3,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            usetime = 500
        }
    },
    ["t135-1"] = {
        label = " ",
         -- '黑石香菸包',
        weight = 45,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            usetime = 500
        }
    },
    ["t136-1"] = {
        label = " ",
         -- '樹妖面具',
        weight = 200,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {
            usetime = 500,
            TriggerEvent("myScript:ToggleEmote")
        }
    },
    ["t137-1"] = {
        label = " ",
         -- '鼓鼓的麻袋',
        weight = 1000,
        stack = false,
        close = true,
        consume = 1,
        description = "",
        client = {
            --event = 'we_core:g1_5637_trash'
            event = "WhalEpic_General:g1_relic_trash"
        }
    },
    ["t138-1"] = {
        label = " ",
         -- '空白符咒',
        weight = 1,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {
            event = "WhalEpic_General:g1_relic_crafting_paper"
        }
    },
    ["t139-1"] = {
        label = " ",
         -- '化妝包',
        weight = 82,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t140-1"] = {
        label = "小護士軟膏",         -- '小護士軟膏',
        weight = 250,
        stack = false,
        close = true,
        consume = 0.151,
        description = "",
        client = {
            status = {stress = 50000},
            notification = "涼涼的"
        }
    },
    ["t141-1"] = {
        label = " ",
         -- '香菸盒',
        weight = 108,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            usetime = 500
        }
    },
    ["t142-1"] = {
        label = " ",
         -- '香菸',
        weight = 54,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            usetime = 500
        }
    },
    ["t144-1"] = {
        label = " ",
         -- '畫具筆帶',
        weight = 1200,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t145-1"] = {
        label = " ",
         -- '一小角紙條',
        weight = 2,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {
            usetime = 500
        }
    },
    ["t146-1"] = {
        label = " ",
         -- '綠色面罩',
        weight = 750,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {
            usetime = 0.0
        }
    },
    ["t147-1"] = {
        label = " ",
         -- '地圖',
        weight = 20,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t148-1"] = {
        label = " ",
         -- '麻將',
        weight = 4200,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t149-1"] = {
        label = " ",
         -- '作物種子包',
        weight = 100,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            usetime = 500
        }
    },
    ["t150-1"] = {
        label = " ",
         -- '白紙',
        weight = 1,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {
            event = "WhalEpic_General:g1_relic_crafting_paper2"
        }
    },
    ["t151-1"] = {
        label = " ",
         -- '紅大衛香菸',
        weight = 300,
        stack = true,
        close = true,
        consume = 0.051,
        description = "",
        client = {
            usetime = 500,
            notification = "你抽了一根菸"
        }
    },
    ["t152-1"] = {
        label = " ",
         -- '平安御守',
        weight = 15,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t153-1"] = {
        label = " ",
         -- '項鍊',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t154-1"] = {
        label = " ",
         -- '濕紙巾',
        weight = 500,
        stack = trur,
        close = true,
        consume = 0.11,
        description = "濕紙巾",
        client = {
            usetime = 2500,
            remove = function(total)
                if total < 1 then
                    lib.notify({description = "用完了!"})
                end
            end
        }
    },
    ["t155-1"] = {
        label = " ",
         -- '玻璃試管',
        weight = 5,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t157-1"] = {
        label = " ",
         -- '男性婚戒',
        weight = 6,
        stack = true,
        close = true,
        consume = 0,
        description = "「戒指內側刻著【杜&聶】的文字」",
        client = {}
    },
    ["t158-1"] = {
        label = " ",
         -- '淨水器',
        weight = 1000,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t159-1"] = {
        label = " ",
         -- '電池',
        weight = 50,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t159-2"] = {
        label = " ",
         -- '沒電電池',
        weight = 50,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t160-1"] = {
        label = " ",
         -- '146MM湯鍋',
        weight = 625,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t161-1"] = {
        label = " ",
         -- '空醬瓶',
        weight = 8,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t162-1"] = {
        label = " ",
         -- '料理本',
        weight = 200,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t163-1"] = {
        label = " ",
         -- '燒烤叉',
        weight = 60,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t164-1"] = {
        label = " ",
         -- '過濾棉',
        weight = 2,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t165-1"] = {
        label = " ",
         -- 簡易過濾器',
        weight = 400,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t166-1"] = {
        label = " ",
         -- '平底鍋',
        weight = 470,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t167-1"] = {
        label = " ",
         -- '簡易濾水器',
        weight = 500,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t168-1"] = {
        label = " ",
         -- '龍貓小吊飾',
        weight = 30,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t169-1"] = {
        label = " ",
         -- '建築圖紙',
        weight = 30,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t170-1"] = {
        label = " ",
         -- '鑰匙',
        weight = 50,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t171-1"] = {
        label = " ",
         -- '膠帶',
        weight = 200,
        stack = true,
        close = true,
        consume = 0.14,
        description = "",
        client = {}
    },
    ["t172-1"] = {
        label = " ",
         -- '噴漆',
        weight = 900,
        stack = true,
        close = true,
        consume = 0.14,
        description = "",
        client = {}
    },
    ["t173-1"] = {
        label = " ",
         -- '螢光棒',
        weight = 900,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {
            usetime = 500
        }
    },
    ["t174-1"] = {
        label = " ",
         -- '便攜酒精爐',
        weight = 105,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t175-1"] = {
        label = " ",
         -- '水晶風鈴',
        weight = 200,
        stack = true,
        close = true,
        consume = 0,
        description = "外表陳舊，但依然能用",
        client = {
            usetime = 500
        }
    },
    ["t176-1"] = {
        label = " ", -- '錄音機'
        weight = 200,
        stack = false,
        close = true,
        consume = 0,
        description = "裡面有放著一張錄音帶",
        client = {}
    },
    ["t177-1"] = {
        label = " ",
         --'白包(5格)',
        weight = 1,
        stack = false,
        close = false,
        consume = 0
    },
    ["t178-1"] = {
        label = " ",
         --'獎盃',
        weight = 1,
        stack = false,
        close = false,
        consume = 0
    },
    ["t179-1"] = {
        label = " ",
         --'訃聞',
        weight = 1,
        stack = false,
        close = false,
        consume = 0
    },
    ["t180-1"] = {
        label = " ",
         -- '女用化妝包(許多化妝品)',
        weight = 1300,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t181-1"] = {
        label = " ",
         -- '男用蕾絲內褲',
        weight = 150,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t182-1"] = {
        label = " ",
         -- '護身符',
        weight = 100,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t183-1"] = {
        label = " ",
         -- '狼人殺邀請函',
        weight = 30,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {
            usetime = 1000
        }
    },
    ["t184-1"] = {
        label = " ",
         -- '素描本',
        weight = 30,
        stack = true,
        close = true,
        consume = 0,
        description = "一本空白的素描本",
        client = {}
    },
    ["t185-1"] = {
        label = " ",
         -- '材料箱',
        weight = 1000,
        stack = false,
        close = true,
        consume = 0,
        description = "材料箱",
        client = {}
    },
    ["t186-1"] = {
        label = " ",
         --'貓紙袋',
        weight = 10,
        stack = false,
        close = false,
        consume = 0,
        description = ""
    },
    ["t187-1"] = {
        label = "空氣鳳梨瓶",      -- '空氣鳳梨瓶',
        weight = 200,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t188-1"] = {
        label = "鳶尾玻璃吊飾",     -- '鳶尾玻璃吊飾',
        weight = 20,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t189-1"] = {
        label = "末路荼蘼香水",      -- '末路荼蘼香水',
        weight = 200,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t190-1"] = {
        label = "恐龍香氛玩偶",      -- '恐龍香氛玩偶',
        weight = 200,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t191-1"] = {
        label = " ",
         -- '寶特瓶線捲',
        weight = 15,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t192-1"] = {
        label = " ",
         -- '接力棒',
        weight = 53,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t193-1"] = {
        label = " ",
         -- '符咒',
        weight = 3,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            usetime = 1600
        }
    },
    ["t194-1"] = {
        label = " ",
         -- '符灰',
        weight = 1,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t195-1"] = {
        label = " ",
         -- '針線包',
        weight = 1,
        stack = true,
        close = true,
        consume = 0,
        description = "可縫紉用之道具",
        client = {}
    },
    ["t196-1"] = {
        label = " ",
         -- '粉紅鑰匙',
        weight = 100,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t197-1"] = {
        label = " ",
         -- '手銬',
        weight = 100,
        stack = false,
        close = true,
        consume = 0,
        description = "手銬",
        client = {}
    },
    ["t198-1"] = {
        label = " ",
         -- '隨身碟',
        weight = 15,
        stack = true,
        close = true,
        consume = 0,
        description = "不知道裏面有什麽，得找台電腦……",
        client = {}
    },
    ["t199-1"] = {
        label = " ",
         -- '萬能房卡',
        weight = 5,
        stack = true,
        close = true,
        consume = 0,
        description = "能打開旅館的所有客房",
        client = {}
    },
    ["t200-1"] = {
        label = " ",
         -- '信用卡附屬卡',
        weight = 5,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t201-1"] = {
        label = " ",
         -- '支票',
        weight = 2,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t202-1"] = {
        label = " ",
         -- '淨空大師之好好說話《有聲書》',
        weight = 650,
        stack = false,
        close = true,
        consume = 0,
        description = "淨空大師之好好說話《有聲書》",
        client = {
            usetime = 1000
        }
    },
    ["t203-1"] = {
        label = " ",
         -- '折起來的紙條',
        weight = 10,
        stack = true,
        close = true,
        consume = 1,
        description = "一張摺起來的紙條",
        client = {
            usetime = 500
        }
    },
    ["t204-1"] = {
        label = " ",
         -- '筊杯',
        weight = 100,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {}
    },
    ["t205-1"] = {
        label = " ",
         -- '籤筒',
        weight = 300,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t206-1"] = {
        label = " ",
         -- '破布',
        weight = 10,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t207-1"] = {
        label = " ",
         -- '廢棄針筒',
        weight = 10,
        stack = true,
        close = true,
        consume = 1,
        description = "",
        client = {
            usetime = 500
        }
    },
    ["t208-1"] = {
        label = " ",
         -- '空麵杯',
        weight = 8,
        stack = true,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },
    ["t209-1"] = {
        label = " ",
         --'鐵斧',
        weight = 1000,
        stack = true,
        close = true
    },
    ["t210-1"] = {
        label = " ",
         --'白鐵支架',
        weight = 250,
        stack = true,
        close = true
    },
    ["t211-1"] = {
        label = " ",
         -- '法蘭絨單人毛毯',
        weight = 650,
        stack = false,
        close = true,
        consume = 0,
        description = "",
        client = {}
    },  
}